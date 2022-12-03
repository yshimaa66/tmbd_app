import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb_app/core/error/failure.dart';
import 'package:tmdb_app/core/services/services_locator.dart';
import 'package:tmdb_app/core/usecase/base_usecase.dart';
import 'package:tmdb_app/features/popular_persons/data/models/all_popular_persons/all_popular_persons.dart';
import 'package:tmdb_app/features/popular_persons/domain/entities/all_popular_persons_entity.dart';
import 'package:tmdb_app/features/popular_persons/domain/repository/popular_persons_repo.dart';

class GetPopularPersonsUseCase
    implements BaseUseCase<Future<Either<Failure, AllPopularPersonsEntity?>>, GetPopularPersonsParameters> {
  @override
  Future<Either<Failure, AllPopularPersonsEntity?>> call(
      GetPopularPersonsParameters parameters) {
    return sl<PopularPersonsRepo>().getAllPopularPersons(parameters.currentPage);
  }
}

class GetPopularPersonsParameters extends Equatable {
  final int currentPage;

  GetPopularPersonsParameters(this.currentPage);

  @override
  List<Object?> get props => [currentPage];
}
