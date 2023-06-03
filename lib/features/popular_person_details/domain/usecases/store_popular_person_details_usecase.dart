import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tmdb_app/core/services/injection.dart';
import 'package:tmdb_app/core/usecase/base_usecase.dart';
import 'package:tmdb_app/features/popular_person_details/domain/entities/popular_person_details_entity.dart';
import 'package:tmdb_app/features/popular_person_details/domain/repository/popular_person_details_repo.dart';

@lazySingleton
class StorePopularPersonDetailsUseCase
    implements BaseUseCase<dynamic, StorePopularPersonDetailsParameters> {
  call(StorePopularPersonDetailsParameters parameters) {
    return getIt<PopularPersonDetailsRepo>()
        .storePopularPersonDetails(parameters.popularPersonDetailsEntity);
  }
}

class StorePopularPersonDetailsParameters extends Equatable {
  final PopularPersonDetailsEntity popularPersonDetailsEntity;

  StorePopularPersonDetailsParameters(this.popularPersonDetailsEntity);

  @override
  List<Object?> get props => [popularPersonDetailsEntity];
}
