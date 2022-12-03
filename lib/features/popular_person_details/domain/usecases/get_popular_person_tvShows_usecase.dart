import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tmdb_app/core/error/failure.dart';
import 'package:tmdb_app/core/services/services_locator.dart';
import 'package:tmdb_app/core/usecase/base_usecase.dart';
import 'package:tmdb_app/features/popular_person_details/domain/entities/popular_person_details_entity.dart';
import 'package:tmdb_app/features/popular_person_details/domain/repository/popular_person_details_repo.dart';
import 'package:tmdb_app/features/popular_person_details/presentation/bloc/popular_person_details_bloc.dart';

class GetPopularPersonTVShowsUseCase
    implements
        BaseUseCase<Future<Either<Failure, PopularPersonDetailsEntity?>>,
            GetPopularPersonTVShowsParameters> {
  Future<Either<Failure, PopularPersonDetailsEntity?>> call(
      GetPopularPersonTVShowsParameters parameters) {
    debugPrint('GetPopularPersonTVShowsUseCase');
    return sl<PopularPersonDetailsRepo>()
        .getPopularPersonTVShows(parameters.popularPersonDetailsEntity);
  }
}

class GetPopularPersonTVShowsParameters extends Equatable {
  final PopularPersonDetailsEntity popularPersonDetailsEntity;

  GetPopularPersonTVShowsParameters(this.popularPersonDetailsEntity);

  @override
  List<Object?> get props => [popularPersonDetailsEntity];
}
