import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tmdb_app/core/error/failure.dart';
import 'package:tmdb_app/core/services/injection.dart';
import 'package:tmdb_app/core/usecase/base_usecase.dart';
import 'package:tmdb_app/features/popular_persons/domain/entities/all_popular_persons_entity.dart';
import 'package:tmdb_app/features/popular_persons/domain/repository/popular_persons_repo.dart';

@lazySingleton
class GetPopularPersonsUseCase
    implements BaseUseCase<Future<Either<Failure, AllPopularPersonsEntity?>>, GetPopularPersonsParameters> {
  @override
  Future<Either<Failure, AllPopularPersonsEntity?>> call(
      GetPopularPersonsParameters parameters) {
    return getIt<PopularPersonsRepo>().getAllPopularPersons(parameters.currentPage);
  }
}

class GetPopularPersonsParameters extends Equatable {
  final int currentPage;

  GetPopularPersonsParameters(this.currentPage);

  @override
  List<Object?> get props => [currentPage];
}
