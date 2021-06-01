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
  List<AyahModel> getAyahsByInputs({
    int? startJuz,
    int? endJuz,
    int? startQuarter,
    int? endQuarter,
    required QuranProvider provider,
  }) {
    Fimber.i('startJuz= $startJuz, '
        'endJuz= $endJuz, '
        'startQuarter= $startQuarter, '
        'endQuarter= $endQuarter, ');

    var ayahs = <AyahModel>[];

    var startRef;
    var endRef;
    var allMeta = provider.quranMetaModel?.data?.hizbQuarters;
    Fimber.i('allMeta= ${allMeta!.references!.length}');
    if (startQuarter != null && endQuarter != null) {
      Fimber.i('## startQuarter != null ##');
      /*
      for example =  startQuarter =1,  endQuarter= 1
      so we need
        start >> hizbQuarters[ 0 => startQuarter-1 ] and
      end >>     hizbQuarters[ 1 => endQuarter]
      */
      var hizbQuarters = provider.quranMetaModel?.data?.hizbQuarters;
      startRef = hizbQuarters?.references![startQuarter - 1];
      Fimber.i('startQuarter= $startQuarter, endQuarter= $endQuarter');

      if (endQuarter != hizbQuarters!.count) {
        endRef = hizbQuarters.references![endQuarter];
      } else {
        endRef = References(surah: 114, ayah: 7);
      }
      ;
    } else if (startJuz != null && endJuz != null) {
      Fimber.i('## startJuz != null ## ');

      var juzs = provider.quranMetaModel?.data?.juzs;
      startRef = juzs?.references![startJuz - 1];
      if (endJuz != juzs?.count) {
        endRef = juzs!.references![endJuz];
      } else {
        endRef = References(surah: 114, ayah: 7);
      }
    } else {
      throw ('all parameters missing, at least juz must be provided ');
    }
    var allSurahs = provider.quranModel?.data?.surahs;

    Fimber.i('allSurahsLen= ${allSurahs!.length}, '
        '\nstartRef =${jsonEncode(startRef)}, '
        'endRef= ${jsonEncode(endRef)}');
    /* for example {"surah":1,"ayah":1}, endRef= {"surah":2,"ayah":26}
        position in list 0,1 >> subList[1-1 ,  2]
     */
    /// sublist of surah to get all surah that we should return ayahs of it
    var surahList = allSurahs.sublist(startRef!.surah! - 1, endRef!.surah!);
    log('surahList= n{jsonEncode(surahList)}');
    var surahListLen = surahList.length;
    Fimber.i('surahListLen= $surahListLen');

    for (var surahIndex = 0; surahIndex < surahListLen; surahIndex++) {
      var surahModel = surahList[surahIndex];
      Fimber.i('surahModel= ${surahModel.number}, ');
      if (surahListLen == 1) {
        Fimber.i('## surahListLen == 1 , case##');

        /// only one surah so start and end ayahs in it
        /// [endRef.ayah -1] coz the ended ayah is the first ayah of next juz
        var ayahsRes =
            surahModel.ayahs?.sublist(startRef.ayah! - 1, endRef.ayah! - 1);
        // Fimber.i('ayahsResLEn= ${jsonEncode(ayahsRes)}');
        Fimber.i('ayahsResLen= ${ayahsRes!.length}');
        ayahs.addAll(ayahsRes);
      } else if (surahListLen > 1) {
        Fimber.i('## surahListLen > 1  , case##');
        // if last surah
        if (surahIndex == surahListLen - 1) {
          Fimber.i('##  last surah , case  ##');

          var ayahsRes = surahModel.ayahs?.sublist(0, endRef.ayah! - 1);
          ayahs.addAll(ayahsRes!);
          Fimber.i('ayahsRes= ${ayahsRes.length}');
        }
        // if first surah and first ayah not equal 1 means that we need to
        // split it
        else if (surahIndex == 0 && startRef.ayah != 1) {
          Fimber.i('##  first surah , case  ##');
          surahModel.number;
          Fimber.i('surahModelNumber = ${surahModel.number}, '
              'startAyahNumber= ${startRef.ayah!}, startRefAyah= ${startRef.ayah}');
          // means ayahs start in middle of surah, so we need to sublist it
          // if (startRef.ayah != 1) {
          /// we didn't put and endIndex coz we only need to curt first ayahs
          /// till end of surah
          var ayahsRes = surahModel.ayahs?.sublist(startRef.ayah - 1);
          var ayahToPrint = ayahsRes!
              .map((e) => '${e.text} (${e.number})')
              .toList()
              .join(' ');
          Fimber.i('ayahToPrint= $ayahToPrint');
          ayahs.addAll(ayahsRes);
          // }
        } else {
          Fimber.i('##  else  , case  ##');
          ayahs.addAll(surahModel.ayahs!);
        }
      }
      Fimber.i('ayahsLen= ${ayahs.length}');
    }
    Fimber.i(
        'finalFirsAyah= ${ayahs.first.text}, number= ${ayahs.first.numberInSurah}');
    Fimber.i(
        'finalLastAyah= ${ayahs.last.text}, number= ${ayahs.last.numberInSurah}');
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

  void quarterAyahs(QuranProvider provider) {
    var ayahsLenList = provider.quranMetaModel!.data!.hizbQuarters!.references!
        .map((References r) => provider
            .quranModel!.data!.surahs![r.surah! - 1].ayahs![r.ayah! - 1])
        .toList()
        .map((e) => e.text!.length)
        .toList();

    Fimber.i('ayahsLenList= $ayahsLenList');
  }

  String getAyahPreview(AyahModel ayahModel) {
    var ayahWordList = ayahModel.text!.split(' ');
    var lastIndex = _getLatIndex(ayahWordList.length);
    var finalWordsList = ayahWordList.sublist(0, lastIndex);
    print('finalArr= $finalWordsList');
    return finalWordsList.join(' ');
  }

  int _getLatIndex(int len) {
    switch (len) {
      case 1:
        return 1;
      case 2:
        return 2;
      case 3:
        return 3;
      default:
        return 4;
    }
  }
}
