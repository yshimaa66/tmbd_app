import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tmdb_app/core/error/exception.dart';
import 'package:tmdb_app/core/error/failure.dart';
import 'package:tmdb_app/core/network/network_info.dart';
import 'package:tmdb_app/core/services/services_locator.dart';
import 'package:tmdb_app/features/popular_persons/data/data_source/local/popular_person_local_data_source.dart';
import 'package:tmdb_app/features/popular_persons/data/data_source/remote/popular_person_remote_data_source.dart';
import 'package:tmdb_app/features/popular_persons/domain/repository/popular_persons_repo.dart';
import 'package:tmdb_app/models/all_popular_persons/all_popular_persons.dart';

class PopularPersonsRepoImpl implements PopularPersonsRepo {
  @override
  Future<Either<Failure, AllPopularPersons?>> getAllPopularPersons(
      int currentPage) async {
    debugPrint("PopularPersonsRepoImpl");
    final bool isConnected = await sl<NetworkInfo>().isConnected;
    if (isConnected) {
      try {
        final result = await sl<PopularPersonsRemoteDataSource>()
            .getAllPopularPersons(page: currentPage);
        debugPrint("PopularPersonsRepoImpl Right");
        return Right(result);
      } on ServerException catch (failure) {
        debugPrint(
            "PopularPersonsRepoImpl ServerException ${failure.errorMessageModel.statusMessage}");
        return Left(Failure(
            failureMessage: failure.errorMessageModel.statusMessage ?? ""));
      } on Failure catch (failure) {
        debugPrint("PopularPersonsRepoImpl Failure ${failure.failureMessage}");
        return Left(Failure(failureMessage: failure.failureMessage ?? ""));
      }
    }
    debugPrint("PopularPersonsRepoImpl No Internet Connection");
    return Left(Failure(failureMessage: "No Internet Connection"));
  }

  @override
  Future storeAllPopularPersons(AllPopularPersons allPopularPersons) async {
    debugPrint(
        "repo impl storeAllPopularPersons ${allPopularPersons.results!.first}");
    await sl<PopularPersonsLocalDataSource>()
        .storeAllPopularPersons(allPopularPersons);
  }

  @override
  Either<Failure, AllPopularPersons?> getAllLocalPopularPersons(
      int currentPage) {
    final result = sl<PopularPersonsLocalDataSource>()
        .getAllLocalPopularPersons(currentPage);
    try {
      return Right(result);
    } on LocalDatabaseException catch (failure) {
      return Left(Failure(failureMessage: failure.errorMessage ?? ""));
    }
  }
}
