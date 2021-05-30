import 'dart:convert';

import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:quran_test/consts/assets.dart';
import 'package:quran_test/data/model/quran/ayah_model/ayah_model.dart';
import 'package:quran_test/data/model/quran/quran_model.dart';
import 'package:quran_test/data/model/quran_meta/quran_meta_model.dart';
import 'package:quran_test/helpers/quran_helper.dart';

class QuranProvider extends ChangeNotifier {
  QuranModel? quranModel;
  QuranMetaModel? quranMetaModel;
  List<AyahModel> ayahModels = [];

  AyahModel? randomAyah;
  String? displayedAyah;
  int _displayedWord = 0;
  int? _maxDisplayedWord;

  QuranProvider() {
    prepareData();
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

  Future<void> prepareData() async {
    await getQuranData();
    await getQuranMetaData();
    // getAyahQuarterModels();
  }

  void setupRandomAyah(List<AyahModel> ayahs) {
    Fimber.i('ayahsLen = ${ayahs.length}');
    ayahModels.clear();
    ayahModels.addAll(ayahs);
    resetRandomAyahData();
    randomAyah = QuranHelper.instance.getRandomElement(ayahModels);
    Fimber.i('randomAyah= $randomAyah');
    var ayahLen = randomAyah?.text?.split(' ').length;
    _maxDisplayedWord = (ayahLen! / 2).round();
    Fimber.i('_maxDisplayedWord= $_maxDisplayedWord');

    setDisplayedAyah();
    // ayahModels.
    notifyListeners();
  }

  bool setDisplayedAyah() {
    // ayah 5 word
    Fimber.i(
        '_displayedWord= $_displayedWord, _maxDisplayedWord= $_maxDisplayedWord');
    _displayedWord++;
    if (_displayedWord <= _maxDisplayedWord!) {
      var ayahWords = randomAyah?.text?.split(' ');
      Fimber.i('ayahWords= $ayahWords, ayahWordsLEn= ${ayahWords?.length}');
      Fimber.i('_displayedWord= $_displayedWord');

      displayedAyah = ayahWords?.sublist(0, _displayedWord).join(' ');
      Fimber.i('_maxDisplayedWord= $_maxDisplayedWord'
          ' displayedAyah= $displayedAyah');

      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  void resetRandomAyahData() {
    _displayedWord = 0;
    _maxDisplayedWord = null;
  }
}
