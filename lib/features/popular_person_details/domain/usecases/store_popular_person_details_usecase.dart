import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb_app/core/error/failure.dart';
import 'package:tmdb_app/core/services/services_locator.dart';
import 'package:tmdb_app/core/usecase/base_usecase.dart';
import 'package:tmdb_app/features/popular_person_details/domain/entities/popular_person_details_entity.dart';
import 'package:tmdb_app/features/popular_person_details/domain/repository/popular_person_details_repo.dart';

class StorePopularPersonDetailsUseCase  implements
    BaseUseCase<dynamic,
        StorePopularPersonDetailsParameters>{
  call(StorePopularPersonDetailsParameters parameters) {
    return sl<PopularPersonDetailsRepo>()
        .storePopularPersonDetails(parameters.popularPersonDetailsEntity);
  }
}

class StorePopularPersonDetailsParameters extends Equatable {
  final PopularPersonDetailsEntity popularPersonDetailsEntity;

  StorePopularPersonDetailsParameters(this.popularPersonDetailsEntity);

  @override
  List<Object?> get props => [popularPersonDetailsEntity];
}
