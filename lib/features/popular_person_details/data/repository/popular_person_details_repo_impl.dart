import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tmdb_app/core/error/exceptions.dart';
import 'package:tmdb_app/core/error/failure.dart';
import 'package:tmdb_app/core/network/network_info.dart';
import 'package:tmdb_app/core/services/services_locator.dart';
import 'package:tmdb_app/features/popular_person_details/data/data_source/local/popular_person_details_local_data_source.dart';
import 'package:tmdb_app/features/popular_person_details/data/data_source/remote/popular_person_details_remote_data_source.dart';
import 'package:tmdb_app/features/popular_person_details/data/models/movie_credits.dart';
import 'package:tmdb_app/features/popular_person_details/data/models/other_images.dart';
import 'package:tmdb_app/features/popular_person_details/data/models/popular_person_details.dart';
import 'package:tmdb_app/features/popular_person_details/data/models/tv_credits.dart';
import 'package:tmdb_app/features/popular_person_details/domain/entities/cast_entity.dart';
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
        final PopularPersonDetails? result =
            await sl<PopularPersonDetailsRemoteDataSource>()
                .getPopularPersonDetails(personId);
        debugPrint("PopularPersonDetailsRepoImpl Right $result");
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
    debugPrint("repo impl storeAllPopularPersons $PopularPersonDetailsEntity");
    await sl<PopularPersonDetailsLocalDataSource>()
        .storePopularPersonDetails(popularPersonDetailsEntity);
  }

  @override
  Future<Either<Failure, PopularPersonDetailsEntity?>> getPopularPersonImages(
      PopularPersonDetailsEntity popularPersonDetailsEntity) async {
    debugPrint("PopularPersonDetailsRepoImpl getPopularPersonImages");
    final bool isConnected = await sl<NetworkInfo>().isConnected;
    if (isConnected) {
      try {
        final OtherImages? result =
            await sl<PopularPersonDetailsRemoteDataSource>()
                .getPopularPersonImages(popularPersonDetailsEntity.id!);
        PopularPersonDetailsEntity newPopularPersonDetailsEntity =
            popularPersonDetailsEntity.copyWith(
          images: result!.profiles!.map((e) => e.filePath ?? "").toList(),
        );
        debugPrint("PopularPersonDetailsRepoImpl Right $result");
        return Right(newPopularPersonDetailsEntity);
      } catch (e) {
        debugPrint("PopularPersonDetailsRepoImpl Failure ${e.toString()}");
        return Left(Failure(failureMessage: e.toString()));
      }
    }
    debugPrint("PopularPersonsRepoImpl No Internet Connection");
    return Left(Failure(failureMessage: "No Internet Connection"));
  }

  @override
  Future<Either<Failure, PopularPersonDetailsEntity?>> getPopularPersonMovies(
      PopularPersonDetailsEntity popularPersonDetailsEntity) async {
    debugPrint("PopularPersonDetailsRepoImpl getPopularPersonMovies");
    final bool isConnected = await sl<NetworkInfo>().isConnected;
    if (isConnected) {
      try {
        final MovieCredits? result =
            await sl<PopularPersonDetailsRemoteDataSource>()
                .getPopularPersonMovies(popularPersonDetailsEntity.id!);
        PopularPersonDetailsEntity newPopularPersonDetailsEntity =
            popularPersonDetailsEntity.copyWith(
          movieCreditCasts: result!.cast!
              .map((e) => CastEntity(
                    name: '',
                    title: e.title,
                    posterPath: e.posterPath,
                    backdropPath: e.backdropPath,
                    voteAverage: e.voteAverage,
                    voteCount: e.voteCount,
                  ))
              .toList(),
        );
        debugPrint("PopularPersonDetailsRepoImpl Right $result");
        return Right(newPopularPersonDetailsEntity);
      } catch (e) {
        debugPrint("PopularPersonDetailsRepoImpl Failure ${e.toString()}");
        return Left(Failure(failureMessage: e.toString()));
      }
    }
    debugPrint("PopularPersonsRepoImpl No Internet Connection");
    return Left(Failure(failureMessage: "No Internet Connection"));
  }

  @override
  Future<Either<Failure, PopularPersonDetailsEntity?>> getPopularPersonTVShows(
      PopularPersonDetailsEntity popularPersonDetailsEntity) async {
    debugPrint("PopularPersonDetailsRepoImpl getPopularPersonTVShows");
    final bool isConnected = await sl<NetworkInfo>().isConnected;
    if (isConnected) {
      try {
        final TVCredits? result =
            await sl<PopularPersonDetailsRemoteDataSource>()
                .getPopularPersonTVShows(popularPersonDetailsEntity.id!);
        PopularPersonDetailsEntity newPopularPersonDetailsEntity =
            popularPersonDetailsEntity.copyWith(
          tvCreditCasts: result!.cast!
              .map((e) => CastEntity(
                    name: e.name,
                    title: "",
                    posterPath: e.posterPath,
                    backdropPath: e.backdropPath,
                    voteAverage: e.voteAverage,
                    voteCount: e.voteCount,
                  ))
              .toList(),
        );
        debugPrint("PopularPersonDetailsRepoImpl Right $result");
        return Right(newPopularPersonDetailsEntity);
      } catch (e) {
        debugPrint("PopularPersonDetailsRepoImpl Failure ${e.toString()}");
        return Left(Failure(failureMessage: e.toString()));
      }
    }
    debugPrint("PopularPersonsRepoImpl No Internet Connection");
    return Left(Failure(failureMessage: "No Internet Connection"));
  }
}
