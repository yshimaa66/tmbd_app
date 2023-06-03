import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tmdb_app/core/services/injection.dart';
import 'package:tmdb_app/core/usecase/base_usecase.dart';
import 'package:tmdb_app/features/popular_persons/domain/entities/all_popular_persons_entity.dart';
import 'package:tmdb_app/features/popular_persons/domain/repository/popular_persons_repo.dart';

@lazySingleton
class StorePopularPersonsUseCase
    implements BaseUseCase<dynamic, StorePopularPersonsParameters> {
  call(StorePopularPersonsParameters parameters) {
    log("StorePopularPersonsUseCase",name: "StorePopularPersonsUseCase");
    return getIt<PopularPersonsRepo>()
        .storeAllPopularPersons(parameters.allPopularPersonsEntity);
  }
}

class StorePopularPersonsParameters extends Equatable {
  final AllPopularPersonsEntity allPopularPersonsEntity;

  StorePopularPersonsParameters(this.allPopularPersonsEntity);

  @override
  List<Object?> get props => [allPopularPersonsEntity];
}
