import 'package:dartz/dartz.dart';
import 'package:tmdb_app/core/error/failure.dart';
import 'package:tmdb_app/features/popular_persons/domain/usecases/get_popular_persons_usecase.dart';
import 'package:tmdb_app/models/all_popular_persons/all_popular_persons.dart';

abstract class PopularPersonsRepo{
  Future<Either<Failure,AllPopularPersons?>>getAllPopularPersons(int currentPage);
  Either<Failure,AllPopularPersons?>getAllLocalPopularPersons(int currentPage);
  Future storeAllPopularPersons(AllPopularPersons allPopularPersons);
}