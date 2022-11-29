import 'package:dartz/dartz.dart';
import 'package:tmdb_app/core/error/failure.dart';
import 'package:tmdb_app/features/popular_person_details/domain/entities/popular_person_details_entity.dart';

abstract class PopularPersonDetailsRepo{
  Future<Either<Failure,PopularPersonDetailsEntity?>>getPopularPersonDetails(int personId);
  Either<Failure,PopularPersonDetailsEntity?>getLocalPopularPersonDetails(int personId);
  Future storePopularPersonDetails(PopularPersonDetailsEntity popularPersonDetailsEntity);
}