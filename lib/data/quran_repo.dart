import 'package:flutter/foundation.dart';
import 'package:quran_test/data/model/all_quran_model.dart';
import 'package:quran_test/data/model/quran/quran_model.dart';
import 'package:quran_test/data/network/Urls.dart';
import 'package:quran_test/data/network/http_api_client.dart';

AllQuranModel parseQuranBody(dynamic responseBody) {
  return AllQuranModel.fromJson(responseBody);
}

class QuranRestRepo extends QuranRepo {
  final HttpApiClient _httpApiClient = HttpApiClient();
  @override
  Future<QuranModel?> getAllQuran() async {
    QuranModel quranModel;

    var quranBody = await _httpApiClient.newGetRequest(path: quranUrl);
    if (quranBody.statusCode == 200) {
      // allQuranModel = await compute(parseQuranBody, quranBody);
      quranModel = QuranModel.fromJson(quranBody.data);

      debugPrint('quranBody= ${quranBody.data}');
      return quranModel;
    }
  }
}

abstract class QuranRepo {
  Future<QuranModel?> getAllQuran();
}
