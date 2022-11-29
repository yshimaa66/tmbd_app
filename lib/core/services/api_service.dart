import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:tmdb_app/core/error/exceptions.dart';
import 'package:tmdb_app/core/error/failure.dart';
import 'package:tmdb_app/core/network/error_message_model.dart';

const _baseUrl = "https://api.themoviedb.org/3";

String get baseUrl => _baseUrl;
String apiKey = "8075ca06e42971c05d4299a914e906df";

class APIService {
  final dio.Dio _client = dio.Dio();

  final _header = {
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  };

  APIService();

  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
    String? query,
  }) async {
    try {
      debugPrint(":: Get $url::");
      if (url.startsWith('/')) {
        url = url.substring(1);
      }

      final response = await _client.get(
        '$baseUrl/$url?api_key=$apiKey&$query',
        options: dio.Options(
          headers: _header,
        ),
        queryParameters: body,
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        debugPrint("APIService get ServerException" + response.statusCode.toString());
        throw ServerException(response.statusMessage);
      }
    }catch (e) {
      if (e is dio.DioError) {
        //handle DioError here by error type or by error code
        throw Failure(failureMessage: e.message);
      } else {
        throw Failure(failureMessage: e.toString());
      }
    //return empty list (you can also return custom error to be handled by Future Builder)
    }
    // on SocketException catch (e) {
    //   debugPrint("APIService get SocketException" + e.toString());
    //   throw Failure("Network connectivity error! Check your internet");
    // } on dio.DioError catch (e) {
    //   debugPrint("APIService get dio.DioError" + e.toString());
    //   throw Failure(e.message);
    // } catch (e) {
    //   debugPrint("APIService get catch(e)" + e.toString());
    //   throw Failure(e.toString());
    // }
  }
}
