import 'dart:developer';

import 'package:quran_test/data/quran_repo.dart';

class QuranHelper {
  QuranHelper._();

  static final QuranHelper instance = QuranHelper._();

  final QuranRestRepo _quranRestRepo = QuranRestRepo();

  Future<void> getAllQuran() async {
    var x = await _quranRestRepo.getAllQuran();

    log('x= ${x.toString().length}');
  }
}
