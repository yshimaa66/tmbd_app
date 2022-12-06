import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tmdb_app/core/error/exceptions.dart';
import 'package:tmdb_app/core/error/failure.dart';
import 'package:tmdb_app/core/network/network_info.dart';
import 'package:tmdb_app/core/services/services_locator.dart';
import 'package:tmdb_app/features/popular_persons/data/data_source/local/popular_persons_local_data_source.dart';
import 'package:tmdb_app/features/popular_persons/data/data_source/remote/popular_persons_remote_data_source.dart';
import 'package:tmdb_app/features/popular_persons/data/models/all_popular_persons/all_popular_persons.dart';
import 'package:tmdb_app/features/popular_persons/domain/entities/all_popular_persons_entity.dart';
import 'package:tmdb_app/features/popular_persons/domain/repository/popular_persons_repo.dart';

class PopularPersonsRepoImpl implements PopularPersonsRepo {
  @override
  Future<Either<Failure, AllPopularPersonsEntity?>> getAllPopularPersons(
      int currentPage) async {
    debugPrint("PopularPersonsRepoImpl");
    final bool isConnected = await sl<NetworkInfo>().isConnected;
    if (isConnected) {
      try {
        final result = await sl<PopularPersonsRemoteDataSource>()
            .getAllPopularPersons(page: currentPage);
        debugPrint("PopularPersonsRepoImpl Right $result");
        return Right(result!.toDomain());
      } catch (e) {
        debugPrint("PopularPersonsRepoImpl Failure ${e.toString()}");
        return Left(Failure(failureMessage: e.toString()));
      }
    }
    debugPrint("PopularPersonsRepoImpl No Internet Connection");
    return Left(Failure(failureMessage: "No Internet Connection"));
  }

  @override
  Future storeAllPopularPersons(AllPopularPersonsEntity allPopularPersonsEntity) async {
    debugPrint(
        "repo impl storeAllPopularPersons ${allPopularPersonsEntity.results!.first}");
    await sl<PopularPersonsLocalDataSource>()
        .storeAllPopularPersons(allPopularPersonsEntity);
  }

  @override
  Either<Failure, AllPopularPersonsEntity?> getAllLocalPopularPersons(
      int currentPage) {
    try {
      final result = sl<PopularPersonsLocalDataSource>()
          .getAllLocalPopularPersons(currentPage);
      return Right(result!);
    } on LocalDatabaseException catch (failure) {
      return Left(Failure(failureMessage: failure.errorMessage ?? ""));
    }
  }
}
