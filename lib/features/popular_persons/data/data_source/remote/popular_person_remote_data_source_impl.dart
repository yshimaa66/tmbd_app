import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tmdb_app/core/error/exception.dart';
import 'package:tmdb_app/core/error/failure.dart';
import 'package:tmdb_app/core/network/error_message_model.dart';
import 'package:tmdb_app/core/services/services_locator.dart';
import 'package:tmdb_app/data/local/person_db.dart';
import 'package:tmdb_app/core/services/api_service.dart';
import 'package:tmdb_app/features/popular_persons/data/data_source/local/popular_person_local_data_source.dart';
import 'package:tmdb_app/features/popular_persons/data/data_source/remote/popular_person_remote_data_source.dart';
import 'package:tmdb_app/main.dart';
import 'package:tmdb_app/models/all_popular_persons/all_popular_persons.dart';

class PopularPersonsRemoteDataSourceImpl
    implements PopularPersonsRemoteDataSource {
  final APIService _apiService;

  PopularPersonsRemoteDataSourceImpl(this._apiService);

  @override
  Future<AllPopularPersons?> getAllPopularPersons({int page = 1}) async {
    try {
      final response = await _apiService.get(
        '/person/popular',
        query: "page=$page",
      );
      final popular = AllPopularPersons.fromJson(response);
      return popular;
    } on ServerException catch (e) {
      debugPrint(
          "PopularPersonsRemoteDataSourceImpl ServerException ${e.errorMessageModel.statusMessage}");
      throw Failure(failureMessage: e.errorMessageModel.statusMessage ?? "");
    } on Failure catch (e) {
      debugPrint(
          "PopularPersonsRemoteDataSourceImpl Failure ${e.failureMessage}");
      throw Failure(failureMessage: e.failureMessage);
    }
  }
}
