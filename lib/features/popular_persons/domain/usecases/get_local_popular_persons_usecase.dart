import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb_app/core/error/failure.dart';
import 'package:tmdb_app/core/services/services_locator.dart';
import 'package:tmdb_app/features/popular_persons/data/models/all_popular_persons/all_popular_persons.dart';
import 'package:tmdb_app/features/popular_persons/domain/repository/popular_persons_repo.dart';

class GetLocalPopularPersonsUseCase {
  Either<Failure, AllPopularPersons?> call(
      GetLocalPopularPersonsParameters parameters) {
    return sl<PopularPersonsRepo>()
        .getAllLocalPopularPersons(parameters.currentPage);
  }
}

class GetLocalPopularPersonsParameters extends Equatable {
  final int currentPage;

  GetLocalPopularPersonsParameters(this.currentPage);

  @override
  List<Object?> get props => [currentPage];
}
