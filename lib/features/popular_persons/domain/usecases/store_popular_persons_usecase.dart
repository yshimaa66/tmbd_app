import 'package:equatable/equatable.dart';
import 'package:tmdb_app/core/services/services_locator.dart';
import 'package:tmdb_app/features/popular_persons/data/models/all_popular_persons/all_popular_persons.dart';
import 'package:tmdb_app/features/popular_persons/domain/repository/popular_persons_repo.dart';

class StorePopularPersonsUseCase {
  call(StorePopularPersonsParameters parameters) {
    return sl<PopularPersonsRepo>()
        .storeAllPopularPersons(parameters.allPopularPersons);
  }
}

class StorePopularPersonsParameters extends Equatable {
  final AllPopularPersons allPopularPersons;

  StorePopularPersonsParameters(this.allPopularPersons);

  @override
  List<Object?> get props => [allPopularPersons];
}
