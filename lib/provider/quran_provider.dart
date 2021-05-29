import 'dart:convert';
import 'dart:developer';

import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:quran_test/consts/assets.dart';
import 'package:quran_test/data/model/quran/quran_model.dart';
import 'package:quran_test/data/model/quran_meta/quran_meta_model.dart';
import 'package:quran_test/helpers/app_helper.dart';

class QuranProvider extends ChangeNotifier {
  QuranModel? quranModel;
  QuranMetaModel? quranMetaModel;

  QuranProvider() {
    getQuranData();
    getQuranMetaData();
  }

  Future<void> getQuranData() async {
    final quranPages = await rootBundle.loadString(allQuranFile);
    quranModel =
        QuranModel.fromJson(jsonDecode(quranPages) as Map<String, dynamic>);
    Fimber.i('quranModel= ${jsonEncode(quranModel)}');

    notifyListeners();
  }

  Future<void> getQuranMetaData() async {
    final quranMetaStr = await rootBundle.loadString(quranMetaFile);
    quranMetaModel = QuranMetaModel.fromJson(
        jsonDecode(quranMetaStr) as Map<String, dynamic>);
    Fimber.i('quranMetaModel= ${jsonEncode(quranMetaModel)}');
    Fimber.i(
        'quranMetaRefs= ${quranMetaModel!.data!.hizbQuarters!.references!.length}');
    // log('quranMetaRefsQurter= ${jsonEncode(quranMetaModel!.data!.hizbQuarters!)}');
    notifyListeners();
  }
}
