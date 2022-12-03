import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tmdb_app/core/error/failure.dart';
import 'package:tmdb_app/core/services/services_locator.dart';
import 'package:tmdb_app/core/usecase/base_usecase.dart';
import 'package:tmdb_app/features/popular_person_details/domain/entities/popular_person_details_entity.dart';
import 'package:tmdb_app/features/popular_person_details/domain/repository/popular_person_details_repo.dart';
import 'package:tmdb_app/features/popular_person_details/presentation/bloc/popular_person_details_bloc.dart';

class GetPopularPersonMoviesUseCase
    implements
        BaseUseCase<Future<Either<Failure, PopularPersonDetailsEntity?>>,
            GetPopularPersonMoviesParameters> {
  Future<Either<Failure, PopularPersonDetailsEntity?>> call(
      GetPopularPersonMoviesParameters parameters) {
    debugPrint('GetPopularPersonMoviesUseCase');
    return sl<PopularPersonDetailsRepo>()
        .getPopularPersonMovies(parameters.popularPersonDetailsEntity);
  }
}

class GetPopularPersonMoviesParameters extends Equatable {
  final PopularPersonDetailsEntity popularPersonDetailsEntity;

  GetPopularPersonMoviesParameters(this.popularPersonDetailsEntity);

  @override
  List<Object?> get props => [popularPersonDetailsEntity];
}
