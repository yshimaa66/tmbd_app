import 'package:dartz/dartz.dart';
import 'package:tmdb_app/core/error/failure.dart';
import 'package:tmdb_app/features/popular_person_details/domain/entities/popular_person_details_entity.dart';

abstract class PopularPersonDetailsRepo {
  Future<Either<Failure, PopularPersonDetailsEntity?>> getPopularPersonDetails(
      int personId);

  Future<Either<Failure, PopularPersonDetailsEntity?>> getPopularPersonImages(
      PopularPersonDetailsEntity popularPersonDetailsEntity);

  Future<Either<Failure, PopularPersonDetailsEntity?>> getPopularPersonMovies(
      PopularPersonDetailsEntity popularPersonDetailsEntity);

  Future<Either<Failure, PopularPersonDetailsEntity?>> getPopularPersonTVShows(
      PopularPersonDetailsEntity popularPersonDetailsEntity);

  Either<Failure, PopularPersonDetailsEntity?> getLocalPopularPersonDetails(
      int personId);

  Future storePopularPersonDetails(
      PopularPersonDetailsEntity popularPersonDetailsEntity);
}
