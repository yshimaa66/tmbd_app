import 'package:dartz/dartz.dart';
import 'package:tmdb_app/core/error/failure.dart';
import 'package:tmdb_app/features/popular_persons/data/models/all_popular_persons/all_popular_persons.dart';
import 'package:tmdb_app/features/popular_persons/domain/entities/all_popular_persons_entity.dart';

abstract class PopularPersonsRepo{
  Future<Either<Failure,AllPopularPersonsEntity?>>getAllPopularPersons(int currentPage);
  Either<Failure,AllPopularPersonsEntity?>getAllLocalPopularPersons(int currentPage);
  Future storeAllPopularPersons(AllPopularPersonsEntity allPopularPersonsEntity);
}