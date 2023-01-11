import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tmdb_app/core/error/failure.dart';
import 'package:tmdb_app/core/services/injection.dart';
import 'package:tmdb_app/core/usecase/base_usecase.dart';
import 'package:tmdb_app/features/popular_persons/domain/entities/all_popular_persons_entity.dart';
import 'package:tmdb_app/features/popular_persons/domain/repository/popular_persons_repo.dart';

@lazySingleton
class GetLocalPopularPersonsUseCase
    implements
        BaseUseCase<Either<Failure, AllPopularPersonsEntity?>,
            GetLocalPopularPersonsParameters> {
  Either<Failure, AllPopularPersonsEntity?> call(
      GetLocalPopularPersonsParameters parameters) {
    return getIt<PopularPersonsRepo>()
        .getAllLocalPopularPersons(parameters.currentPage);
  }
}

class GetLocalPopularPersonsParameters extends Equatable {
  final int currentPage;

  GetLocalPopularPersonsParameters(this.currentPage);

  @override
  List<Object?> get props => [currentPage];
}
