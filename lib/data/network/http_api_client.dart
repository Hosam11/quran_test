import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:quran_test/helpers/app_helper.dart';

class HttpApiClient {
  factory HttpApiClient() {
    return _instance;
  }

  HttpApiClient._privateConstructor();

  static final HttpApiClient _instance = HttpApiClient._privateConstructor();

  Future<Response<dynamic>> newGetRequest({
    required String path,
    Map<String, String>? header,
  }) async {
    var head = '@@ $runtimeType @@ newGetRequest()';
    var response = await Dio().get(path);

    final statusCode = response.statusCode;
    Logger().i(
        'code={$statusCode}, returnedBodyType= ${response.data.runtimeType}');
    // printWrapped('$head returnedBody= ${response.data}');
    return response;
  }
}
