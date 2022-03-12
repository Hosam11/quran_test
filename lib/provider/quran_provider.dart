import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:quran_test/consts/assets.dart';
import 'package:quran_test/data/model/quran/ayah_model/ayah_model.dart';
import 'package:quran_test/data/model/quran/quran_model.dart';
import 'package:quran_test/data/model/quran_meta/quran_meta_model.dart';
import 'package:quran_test/helpers/quran_helper.dart';
import 'package:collection/collection.dart';

class QuranProvider extends ChangeNotifier {
  QuranModel? quranModel;
  QuranMetaModel? quranMetaModel;
  List<AyahModel> ayahModels = [];
  List<AyahModel> hizbQuModels = [];
  List<AyahModel> ayatDetails = [];
  AyahModel? randomAyah;
  String? displayedAyah;
  String? randomSurahName;
  Map<String, String> ayahWithQuarters = {};

  // String? setSurahName(number) => quranModel?.data?.surahs?[number].name;
  String? surahName;

  void setSurahName(int surahNumber) {
    // Fixme: remove it
    debugPrint('QuranProvider.setSurahName  surahNumber= $surahNumber');

    surahName = quranModel?.data?.surahs?[surahNumber].name;
    notifyListeners();
  }

  int _displayedWord = 0;

  // int? _maxDisplayedWord;
  int _ayahLen = 0;
  bool isWordAvailable = true;

  QuranProvider() {
    prepareData();
  }

  Future<void> prepareData() async {
    await getQuranData();
    await getQuranMetaData();
    await getAyatDetails();
    await getAyahWithQuarters();
    getAyahQuarterModels();
  }

  void getAyahQuarterModels() {
    hizbQuModels = quranMetaModel!.data!.hizbQuarters!.references!
        .map((r) => quranModel!.data!.surahs![r.surah! - 1].ayahs![r.ayah! - 1])
        .toList();
    Fimber.i('hizbQuModels.len= ${hizbQuModels.length}');
    var ayahsLenList = quranMetaModel!.data!.hizbQuarters!.references!
        .map((References r) =>
            quranModel!.data!.surahs![r.surah! - 1].ayahs![r.ayah! - 1])
        .toList()
        .map((e) => e.text!.length)
        .toList();

    var minLen = ayahsLenList.reduce(math.min);

    Fimber.i('\nayahQuarterModelsLen = ${hizbQuModels.length},'
        '\nfirst= ${hizbQuModels.first}'
        '\nlast= ${hizbQuModels.last}'
        '\ninLen= $minLen');
    notifyListeners();
  }

  Future<void> getQuranData() async {
    final quranPages = await rootBundle.loadString(allQuranFile);
    quranModel =
        QuranModel.fromJson(jsonDecode(quranPages) as Map<String, dynamic>);
    // Fimber.i('quranModel= ${jsonEncode(quranModel)}');
    Fimber.i('surahsLen = ${quranModel!.data!.surahs!.length}');

    // notifyListeners();
  }

  Future<void> getQuranMetaData() async {
    final quranMetaStr = await rootBundle.loadString(quranMetaFile);
    quranMetaModel = QuranMetaModel.fromJson(
        jsonDecode(quranMetaStr) as Map<String, dynamic>);

    Fimber.i(
        'quranMetaReferencesLen= ${quranMetaModel!.data!.hizbQuarters!.references!.length}');
    // notifyListeners();
  }

  Future<void> getAyatDetails() async {
    final ayat = await rootBundle.loadString(ayatDetailsFile);
    final ayatList = jsonDecode(ayat) as List;
    ayatDetails = ayatList.map((e) => AyahModel.fromJson(e)).toList();
    Fimber.i('ayatDetails= ${ayatDetails.length}');
  }

  Future<void> getAyahWithQuarters() async {
    final ayahWithQuarter = await rootBundle.loadString(ayahWithQuarterFile);
    ayahWithQuarters =
        QuranHelper.instance.quarterAyahFromJson(ayahWithQuarter);
  }

  void setupRandomAyah(List<AyahModel> ayahs) {
    Fimber.i('ayahsLen = ${ayahs.length}');
    ayahModels.clear();
    ayahModels.addAll(ayahs);
    resetRandomAyahData();
    randomAyah = QuranHelper.instance.getRandomElement(ayahModels);
    Fimber.i('randomAyah= $randomAyah');
    var ayahLen = randomAyah?.text?.split(' ').length;
    _ayahLen = ayahLen!;
    Fimber.i('ayahLen= $ayahLen  ');
    // _maxDisplayedWord = (ayahLen / 2).round();
    // Fimber.i('_maxDisplayedWord= $_maxDisplayedWord');

    setDisplayedAyah();
    // ayahModels.
    notifyListeners();
  }

  void setDisplayedAyah() {
    // ayah 5 word
    // Fimber.i(
    //     '_displayedWord= $_displayedWord, _maxDisplayedWord= $_maxDisplayedWord');
    _displayedWord++;
    if (_displayedWord <= _ayahLen) {
      var ayahWords = randomAyah?.text?.split(' ');
      Fimber.i('ayahWords= $ayahWords, ayahWordsLen= ${ayahWords?.length}');
      Fimber.i('_displayedWord= $_displayedWord');

      displayedAyah = ayahWords?.sublist(0, _displayedWord).join(' ');
      Fimber.i('_ayahLen= $_ayahLen'
          ' displayedAyah= $displayedAyah');
    } else {
      isWordAvailable = false;
    }
    notifyListeners();
    // return false;
  }

  void resetRandomAyahData() {
    _displayedWord = 0;
    // _maxDisplayedWord = null;
    isWordAvailable = true;
  }

  void getSurahName() {
    if (randomAyah != null) {
      final ayah = ayatDetails.firstWhereOrNull((a) =>
          a.juz == randomAyah!.juz &&
          a.hizbQuarter == randomAyah!.hizbQuarter &&
          a.page == randomAyah!.page &&
          a.numberInSurah == randomAyah!.numberInSurah);
      if (ayah != null) {
        randomSurahName = ayah.surahName;
      } else {
        randomSurahName = null;
      }
    } else {
      randomSurahName = null;
    }
  }

  void getQuarterName() {
    final quarterAyah = ayatDetails.firstWhereOrNull(
      (a) =>
          a.numberInSurah == randomAyah!.numberInSurah &&
          a.number == randomAyah!.number,
    );
    Fimber.i('quarterAyah= $quarterAyah');
  }

  String? getQuarterText(int value) => ayahWithQuarters[value.toString()];

  Future<void> writeToFile(object, String fileName) async =>
      await File(fileName).writeAsString(jsonEncode(object));
}
