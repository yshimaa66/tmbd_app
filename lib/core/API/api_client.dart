import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tmdb_app/core/API/api_consumer.dart';
import 'package:tmdb_app/core/API/api_interceptors.dart';
import 'package:tmdb_app/core/API/end_points.dart';
import 'package:tmdb_app/core/API/status_code.dart';
import 'package:tmdb_app/core/error/exceptions.dart';
import 'package:tmdb_app/core/services/injection.dart';
import 'package:tmdb_app/core/utils/app_strings.dart';

@LazySingleton(as: ApiConsumer)
class DioConsumer implements ApiConsumer {
  final Dio client;

  DioConsumer({required this.client}) {
    (client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    client.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! == StatusCode.ok;
      };
    client.interceptors.add(getIt<AppInterceptors>());
  }

  @override
  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.get(path, queryParameters: queryParameters);
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future post(
    String path, {
    Map<String, dynamic>? body,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.post(
        path,
        queryParameters: queryParameters,
        data: formDataIsEnabled ? FormData.fromMap(body!) : body,
      );
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future put(String path,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await client.put(path, queryParameters: queryParameters, data: body);
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  dynamic _handleResponseAsJson(Response<dynamic> response) {
    final responseJson = jsonDecode(response.data.toString());
    return responseJson;
  }

  dynamic _handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw const FetchDataException();
      case DioErrorType.response:
        final responseJson = jsonDecode(error.response!.data.toString());
        switch (error.response?.statusCode) {
          case StatusCode.badRequest:
            throw BadRequestException(
              responseJson[AppStrings.apiErrorMessageKey].toString(),
            );
          case StatusCode.unauthorized:
          case StatusCode.forbidden:
            throw UnauthorizedException(
              responseJson[AppStrings.apiErrorMessageKey].toString(),
            );
          case StatusCode.notFound:
            throw NotFoundException(
              responseJson[AppStrings.apiErrorMessageKey].toString(),
            );
          case StatusCode.conflict:
            throw ConflictException(
              responseJson[AppStrings.apiErrorMessageKey].toString(),
            );

          case StatusCode.internalServerError:
            throw InternalServerErrorException(
              responseJson[AppStrings.apiErrorMessageKey].toString(),
            );
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        final responseJson = jsonDecode(error.response!.data.toString());
        throw NoInternetConnectionException(
          responseJson[AppStrings.apiErrorMessageKey].toString(),
        );
    }
  }
}
