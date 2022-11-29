import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb_app/core/error/failure.dart';
import 'package:tmdb_app/core/services/services_locator.dart';
import 'package:tmdb_app/features/popular_person_details/domain/entities/popular_person_details_entity.dart';
import 'package:tmdb_app/features/popular_person_details/domain/repository/popular_person_details_repo.dart';

class GetLocalPopularPersonDetailsUseCase {
  Either<Failure, PopularPersonDetailsEntity?> call(
      GetLocalPopularPersonDetailsParameters parameters) {
    return sl<PopularPersonDetailsRepo>()
        .getLocalPopularPersonDetails(parameters.personId);
  }
}

class GetLocalPopularPersonDetailsParameters extends Equatable {
  final int personId;

  GetLocalPopularPersonDetailsParameters(this.personId);

  @override
  List<Object?> get props => [personId];
}
