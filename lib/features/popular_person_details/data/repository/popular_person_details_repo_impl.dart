import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tmdb_app/core/error/exceptions.dart';
import 'package:tmdb_app/core/error/failure.dart';
import 'package:tmdb_app/core/network/network_info.dart';
import 'package:tmdb_app/core/services/services_locator.dart';
import 'package:tmdb_app/features/popular_person_details/data/data_source/local/popular_person_details_local_data_source.dart';
import 'package:tmdb_app/features/popular_person_details/data/data_source/remote/popular_person_details_remote_data_source.dart';
import 'package:tmdb_app/features/popular_person_details/domain/entities/popular_person_details_entity.dart';
import 'package:tmdb_app/features/popular_person_details/domain/repository/popular_person_details_repo.dart';
import 'package:tmdb_app/features/popular_persons/data/data_source/local/popular_persons_local_data_source.dart';
import 'package:tmdb_app/features/popular_persons/data/data_source/remote/popular_persons_remote_data_source.dart';
import 'package:tmdb_app/features/popular_persons/data/models/all_popular_persons/all_popular_persons.dart';
import 'package:tmdb_app/features/popular_persons/domain/entities/all_popular_persons_entity.dart';
import 'package:tmdb_app/features/popular_persons/domain/repository/popular_persons_repo.dart';

class PopularPersonDetailsRepoImpl implements PopularPersonDetailsRepo {
  @override
  Either<Failure, PopularPersonDetailsEntity?> getLocalPopularPersonDetails(
      int personId) {
    final result = sl<PopularPersonDetailsLocalDataSource>()
        .getLocalPopularPersonDetails(personId);
    try {
      return Right(result!);
    } on LocalDatabaseException catch (failure) {
      return Left(Failure(failureMessage: failure.errorMessage ?? ""));
    }
  }

  @override
  Future<Either<Failure, PopularPersonDetailsEntity?>> getPopularPersonDetails(
      int personId) async {
    debugPrint("PopularPersonDetailsRepoImpl");
    final bool isConnected = await sl<NetworkInfo>().isConnected;
    if (isConnected) {
      try {
        final result = await sl<PopularPersonDetailsRemoteDataSource>()
            .getPopularPersonDetails(personId);
        debugPrint("PopularPersonDetailsRepoImpl Right");
        return Right(result!.toDomain());
      } catch (e) {
        debugPrint("PopularPersonDetailsRepoImpl Failure ${e.toString()}");
        return Left(Failure(failureMessage: e.toString()));
      }
    }
    debugPrint("PopularPersonsRepoImpl No Internet Connection");
    return Left(Failure(failureMessage: "No Internet Connection"));
  }

  @override
  Future storePopularPersonDetails(
      PopularPersonDetailsEntity popularPersonDetailsEntity) async {
    debugPrint(
        "repo impl storeAllPopularPersons $PopularPersonDetailsEntity");
    await sl<PopularPersonDetailsLocalDataSource>()
    .storePopularPersonDetails(popularPersonDetailsEntity);
  }
}
