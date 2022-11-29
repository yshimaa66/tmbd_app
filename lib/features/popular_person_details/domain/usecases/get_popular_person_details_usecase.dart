import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tmdb_app/core/error/failure.dart';
import 'package:tmdb_app/core/services/services_locator.dart';
import 'package:tmdb_app/features/popular_person_details/domain/entities/popular_person_details_entity.dart';
import 'package:tmdb_app/features/popular_person_details/domain/repository/popular_person_details_repo.dart';

class GetPopularPersonDetailsUseCase {
  Future<Either<Failure, PopularPersonDetailsEntity?>> call(
      GetPopularPersonDetailsParameters parameters) {
    debugPrint('GetPopularPersonDetailsUseCase');
    return sl<PopularPersonDetailsRepo>()
        .getPopularPersonDetails(parameters.personId);
  }
}

class GetPopularPersonDetailsParameters extends Equatable {
  final int personId;

  GetPopularPersonDetailsParameters(this.personId);

  @override
  List<Object?> get props => [personId];
}
