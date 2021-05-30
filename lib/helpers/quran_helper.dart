import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:fimber/fimber.dart';
import 'package:flutter/services.dart';
import 'package:quran_test/consts/assets.dart';
import 'package:quran_test/data/model/quran/ayah_model/ayah_model.dart';
import 'package:quran_test/data/model/quran/quran_data/quran_data.dart';
import 'package:quran_test/data/model/quran/quran_model.dart';
import 'package:quran_test/data/model/quran/surah_model/surah_model.dart';
import 'package:quran_test/data/model/quran_meta/quran_meta_model.dart';
import 'package:quran_test/data/quran_repo.dart';
import 'package:quran_test/provider/quran_provider.dart';

class QuranHelper {
  QuranHelper._();

  static final QuranHelper instance = QuranHelper._();

  final QuranRestRepo _quranRestRepo = QuranRestRepo();

  /* Future<void> getQuranFromFile() async {
    final quranPages = await rootBundle.loadString(allQuranFile);
    var quranModel =
        QuranModel.fromJson(jsonDecode(quranPages) as Map<String, dynamic>);
    Fimber.i('quranModel= ${jsonEncode(quranModel)}');
  }

  Future<void> getQuranMetaFromFile() async {
    final quranMetaStr = await rootBundle.loadString(quranMetaFile);
    var quranMetaModel = QuranMetaModel.fromJson(
        jsonDecode(quranMetaStr) as Map<String, dynamic>);
    Fimber.i('quranMetaModel= ${jsonEncode(quranMetaModel)}');
  }*/

  List<AyahModel> getAyahsByInputs({
    int? startJuz,
    int? endJuz,
    int? startQuarter,
    int? endQuarter,
    required QuranProvider provider,
  }) {
    Fimber.i('startJuz= $startJuz'
        'endJuz= $endJuz'
        'startQuarter= $startQuarter'
        'endQuarter= $endQuarter');
    /* Example
     1-
      start suz= 1, end = 1
      get firstJuz= juz[start-1=0]  {surah=1 , ayah 1}
      get endJuz= juz[end]    {surah =2 , ayah 149 {start of next juz} }
     2-
      split all quran surah by start surah number and end
      [] of targetSurahs = allSurahs.split[startSurahNumber -1, endSurahNumber]
      loop on target targetSurahs two case:
       first: if there is only one surah so the start and end of target ayahs
        in same surah.
        targetAyahs = split by [startAyahNumber -1, endAyahNumber -1]
      second: more than one surah 2 option
        1- check if this surah last surah so
          targetAyahs = split by [0, endAyahNumber -1]
        2- else add all ayahs
    */
    var ayahs = <AyahModel>[];

    var startRef;
    var endRef;
    var allMeta = provider.quranMetaModel?.data?.hizbQuarters;
    Fimber.i('allMeta= ${allMeta!.references!.length}');
    if (startQuarter != null && endQuarter != null) {
      Fimber.i('startQuarter != null');
      startRef = provider
          .quranMetaModel?.data?.hizbQuarters?.references![startQuarter - 1];
      Fimber.i('startQuarter= $startQuarter, endQuarter= $endQuarter');
      endRef =
          provider.quranMetaModel?.data?.hizbQuarters?.references![endQuarter];
    } else if (startJuz != null && endJuz != null) {
      Fimber.i('startJuz != null');

      startRef = provider.quranMetaModel?.data?.juzs?.references![startJuz - 1];
      endRef = provider.quranMetaModel?.data?.juzs?.references![endJuz];
    } else {
      throw ('all parameters missing, at least juz must be provided ');
    }
    var allSurahs = provider.quranModel?.data?.surahs;

    Fimber.i('allSurahsLen= ${allSurahs!.length} '
        'startRef =${jsonEncode(startRef)},'
        'endRef= ${jsonEncode(endRef)}');

    /// sublist of surah to get all surah that we should return ayahs of it
    var surahList = allSurahs.sublist(startRef!.surah! - 1, endRef!.surah!);
    log('surahList= n{jsonEncode(surahList)}');
    var surahListLen = surahList.length;
    Fimber.i('surahListLen= $surahListLen');

    for (var surahIndex = 0; surahIndex < surahListLen; surahIndex++) {
      var surahModel = surahList[surahIndex];
      Fimber.i('surahModel= ${surahModel.number}, ');
      if (surahListLen == 1) {
        /// only one surah so start and end ayahs in it
        /// [endRef.ayah -1] coz the ended ayah is the first ayah of next juz
        var ayahsRes =
            surahModel.ayahs?.sublist(startRef.ayah! - 1, endRef.ayah! - 1);

        // Fimber.i('ayahsResLEn= ${jsonEncode(ayahsRes)}');
        Fimber.i('surahListLen:1, ayahsResLen= ${ayahsRes!.length}');
        ayahs.addAll(ayahsRes);
      } else if (surahListLen > 1) {
        // if last surah
        if (surahIndex == surahListLen - 1) {
          var ayahsRes = surahModel.ayahs?.sublist(0, endRef.ayah! - 1);
          ayahs.addAll(ayahsRes!);
          Fimber.i('surahListLen > 1, ayahsRes= ${ayahsRes.length}');
        } else {
          ayahs.addAll(surahModel.ayahs!);
        }
      }
      Fimber.i('ayahsLen= ${ayahs.length}');
    }

    return ayahs;
  }

  /// todo: this  NOT used
  void loopAllQuran(QuranData? quranData) {
    quranData?.surahs?.forEach((SurahModel surahModel) {
      print('surahNumber= ${surahModel.number}');

      surahModel.ayahs?.forEach((AyahModel ayahModel) {
        ayahModel.number;
        print('ayahNumber= ${ayahModel.number}');
      });
    });
  }

  T getRandomElement<T>(List<T> list) {
    final random = math.Random();
    var i = random.nextInt(list.length);
    Fimber.i('i= $i');
    return list[i];
  }
}
