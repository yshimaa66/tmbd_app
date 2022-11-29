import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:tmdb_app/core/utils/enums.dart';
import 'package:tmdb_app/features/popular_person_details/data/models/popular_person_details.dart';
import 'package:tmdb_app/features/popular_person_details/domain/entities/popular_person_details_entity.dart';
import 'package:tmdb_app/features/popular_person_details/domain/usecases/get_local_popular_person_details_usecase.dart';
import 'package:tmdb_app/features/popular_person_details/domain/usecases/get_popular_person_details_usecase.dart';
import 'package:tmdb_app/features/popular_person_details/domain/usecases/store_popular_person_details_usecase.dart';
import 'package:tmdb_app/features/popular_persons/domain/entities/popular_person_entity.dart';

part 'popular_person_details_event.dart';

part 'popular_person_details_state.dart';

class PopularPersonDetailsBloc
    extends Bloc<PopularPersonDetailsEvent, PopularPersonDetailsState> {
  final GetPopularPersonDetailsUseCase getPopularPersonDetailsUseCase;
  final StorePopularPersonDetailsUseCase storePopularPersonDetailsUseCase;
  final GetLocalPopularPersonDetailsUseCase getLocalPopularPersonDetailsUseCase;

  PopularPersonDetailsBloc(
      this.getPopularPersonDetailsUseCase,
      this.storePopularPersonDetailsUseCase,
      this.getLocalPopularPersonDetailsUseCase)
      : super(PopularPersonDetailsState()) {
    on<PopularPersonDetailsEvent>((event, emit) {
      on<GetPopularPersonDetails>(_getPopularPersonDetail);
      on<GetLocalPopularPersonDetails>(_getLocalPopularPersonDetails);
    });
  }

  FutureOr<void> _getPopularPersonDetail(GetPopularPersonDetails event,
      Emitter<PopularPersonDetailsState> emit) async {
    debugPrint("_getPopularPersonDetail RequestState.loading ${event.personId}");

    emit(state.copyWith(
      requestState: RequestState.loading,
    ));

    debugPrint("_getPopularPersonDetail ${event.personId}");

    final result = await getPopularPersonDetailsUseCase(
        GetPopularPersonDetailsParameters(event.personId!));

    result.fold((l) {
      debugPrint("left getPopularPersonDetails $l");
      return emit(state.copyWith(
        requestState: RequestState.error,
        errorMessage: l.failureMessage,
        dataSource: DataSource.remote,
      ));
    }, (r) {
      // TODO : implement entity
      if (r != null) {
        debugPrint("right getPopularPersonDetails $r");
        storePopularPersonDetailsUseCase(
            StorePopularPersonDetailsParameters(r));
        return emit(state.copyWith(
          popularPersonDetails: r,
          requestState: RequestState.loaded,
          errorMessage: "",
          dataSource: DataSource.remote,
        ));
      } else {
        return emit(state.copyWith(
          requestState: RequestState.error,
          errorMessage: "No remote data",
          dataSource: DataSource.remote,
        ));
      }
    });
  }

  FutureOr<void> _getLocalPopularPersonDetails(
      GetLocalPopularPersonDetails event,
      Emitter<PopularPersonDetailsState> emit) async {
    final result = await getLocalPopularPersonDetailsUseCase(
        GetLocalPopularPersonDetailsParameters(event.personId!));
    result.fold((l) {
      debugPrint("left getLocalPopularPersonDetails $l");
      return emit(state.copyWith(
        requestState: RequestState.error,
        errorMessage: l.failureMessage,
        dataSource: DataSource.local,
      ));
    }, (r) async {
      // TODO : implement entity
      if (r != null) {
        debugPrint("_getLocalPopularPersonDetails $r");
        return emit(state.copyWith(
          popularPersonDetails: r,
          requestState: RequestState.loaded,
          errorMessage: "",
          dataSource: DataSource.local,
        ));
      } else {
        return emit(state.copyWith(
          requestState: RequestState.loaded,
          errorMessage: "No local data",
          dataSource: DataSource.local,
        ));
      }
    });
  }
}
