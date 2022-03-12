import 'package:dio/dio.dart';
import 'package:fimber/fimber.dart';

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
    var response = await Dio().get(path);

    final statusCode = response.statusCode;
    Fimber.i(
        'code={$statusCode}, returnedBodyType= ${response.data.runtimeType}');
    // printWrapped('$head returnedBody= ${response.data}');
    return response;
  }
}
