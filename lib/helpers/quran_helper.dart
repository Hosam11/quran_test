import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:quran_test/consts/assets.dart';
import 'package:quran_test/data/model/quran/ayah_model/ayah_model.dart';
import 'package:quran_test/data/model/quran/quran_data/quran_data.dart';
import 'package:quran_test/data/model/quran/surah_model/surah_model.dart';
import 'package:quran_test/data/quran_repo.dart';
import 'package:quran_test/helpers/app_helper.dart';

class QuranHelper {
  QuranHelper._();

  static final QuranHelper instance = QuranHelper._();

  final QuranRestRepo _quranRestRepo = QuranRestRepo();

  Future<void> getAllQuran() async {
    var allQuranList = await _quranRestRepo.getAllQuran();

    Timeline.startSync('interesting function');
    loopAllQuran(allQuranList?.data);
    Timeline.finishSync();
    Timeline.startSync('end function');

    logger.i('surahsList= ${allQuranList?.data?.surahs?.length}');
  }

  Future<void> getQuranFromFile() async {
    final formPageStr =
        // await rootBundle.loadString(Assets.notRequiredDynamicForm);
        await rootBundle.loadString(allQuranFile);
  }

  void loopAllQuran(QuranData? quranData) {
    quranData?.surahs?.forEach((SurahModel surahModel) {
      print('surahNumber= ${surahModel.number}');

      surahModel.ayahs?.forEach((AyahModel ayahModel) {
        ayahModel.number;
        print('ayahNumber= ${ayahModel.number}');
      });
    });
  }
}
