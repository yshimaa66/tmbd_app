import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tmdb_app/core/error/failure.dart';
import 'package:tmdb_app/core/services/injection.dart';
import 'package:tmdb_app/core/usecase/base_usecase.dart';
import 'package:tmdb_app/features/popular_person_details/domain/entities/popular_person_details_entity.dart';
import 'package:tmdb_app/features/popular_person_details/domain/repository/popular_person_details_repo.dart';

@lazySingleton
class GetLocalPopularPersonDetailsUseCase
    implements
        BaseUseCase<Either<Failure, PopularPersonDetailsEntity?>,
            GetLocalPopularPersonDetailsParameters> {
  Either<Failure, PopularPersonDetailsEntity?> call(
      GetLocalPopularPersonDetailsParameters parameters) {
    return getIt<PopularPersonDetailsRepo>()
        .getLocalPopularPersonDetails(parameters.personId);
  }
}

class GetLocalPopularPersonDetailsParameters extends Equatable {
  final int personId;

  GetLocalPopularPersonDetailsParameters(this.personId);

  @override
  List<Object?> get props => [personId];
}
