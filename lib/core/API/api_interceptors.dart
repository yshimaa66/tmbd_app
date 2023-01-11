import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:tmdb_app/core/API/api_config.dart';

@lazySingleton
class AppInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll(
      ApiConfig.queryParameters,
    );
    options.headers["Content-Type"] = "application/json; charset=utf-8";
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.statusMessage}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint('ERROR[${err.response?.statusCode}] => PATH: ${err.response}');

    super.onError(err, handler);
  }
}