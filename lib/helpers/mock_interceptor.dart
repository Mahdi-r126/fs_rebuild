import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class MockInterceptor extends Interceptor {
  static const _jsonDir = 'assets/json/themes';

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final resourcePath = _jsonDir + options.path;
    final data = await rootBundle.load(resourcePath);
    final map = json.decode(
      utf8.decode(
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
      ),
    );

    var response = Response(
      data: map,
      statusCode: 200, requestOptions: RequestOptions(
        baseUrl: 'fake',
        method: 'GET',
        path: '/bank_ads.json')
    );

    handler.resolve(response, true);
  }

}