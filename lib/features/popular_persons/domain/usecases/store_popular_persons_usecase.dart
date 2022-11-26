import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb_app/core/error/failure.dart';
import 'package:tmdb_app/core/services/services_locator.dart';
import 'package:tmdb_app/core/usecase/base_usecase.dart';
import 'package:tmdb_app/features/popular_persons/domain/repository/popular_persons_repo.dart';
import 'package:tmdb_app/models/all_popular_persons/all_popular_persons.dart';

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
