import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:tmdb_app/core/error/exceptions.dart';
import 'package:tmdb_app/core/error/failure.dart';
import 'package:tmdb_app/core/network/network_info.dart';
import 'package:tmdb_app/core/services/injection.dart';
import 'package:tmdb_app/features/popular_persons/data/data_source/local/popular_persons_LDS.dart';
import 'package:tmdb_app/features/popular_persons/data/data_source/remote/popular_persons_RDS.dart';
import 'package:tmdb_app/features/popular_persons/domain/entities/all_popular_persons_entity.dart';
import 'package:tmdb_app/features/popular_persons/domain/repository/popular_persons_repo.dart';

@LazySingleton(as: PopularPersonsRepo)
class PopularPersonsRepoImpl implements PopularPersonsRepo {
  @override
  Future<Either<Failure, AllPopularPersonsEntity?>> getAllPopularPersons(
      int currentPage) async {
    log("PopularPersonsRepoImpl");
    final bool isConnected = await getIt<NetworkInfo>().isConnected;
    if (isConnected) {
      try {
        final result = await getIt<PopularPersonsRemoteDataSource>()
            .getAllPopularPersons(page: currentPage);
        log("PopularPersonsRepoImpl Right $result");
        return Right(result!.toDomain());
      } catch (e) {
        log("PopularPersonsRepoImpl Failure ${e.toString()}");
        return Left(Failure(failureMessage: e.toString()));
      }
    }
    log("PopularPersonsRepoImpl No Internet Connection");
    return Left(Failure(failureMessage: "No Internet Connection"));
  }

  @override
  Future storeAllPopularPersons(AllPopularPersonsEntity allPopularPersonsEntity) async {
    log(
        "repo impl storeAllPopularPersons ${allPopularPersonsEntity.results!.first}");
    await getIt<PopularPersonsLocalDataSource>()
        .storeAllPopularPersons(allPopularPersonsEntity);
  }

  @override
  Either<Failure, AllPopularPersonsEntity?> getAllLocalPopularPersons(
      int currentPage) {
    try {
      final result = getIt<PopularPersonsLocalDataSource>()
          .getAllLocalPopularPersons(currentPage);
      return Right(result!);
    } on LocalDatabaseException catch (failure) {
      return Left(Failure(failureMessage: failure.errorMessage ?? ""));
    }
  }
}
