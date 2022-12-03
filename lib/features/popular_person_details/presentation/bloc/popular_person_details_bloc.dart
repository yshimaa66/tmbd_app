import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:tmdb_app/core/utils/enums.dart';
import 'package:tmdb_app/features/popular_person_details/domain/entities/popular_person_details_entity.dart';
import 'package:tmdb_app/features/popular_person_details/domain/usecases/get_local_popular_person_details_usecase.dart';
import 'package:tmdb_app/features/popular_person_details/domain/usecases/get_popular_person_details_usecase.dart';
import 'package:tmdb_app/features/popular_person_details/domain/usecases/get_popular_person_images_usecase.dart';
import 'package:tmdb_app/features/popular_person_details/domain/usecases/get_popular_person_movies_usecase.dart';
import 'package:tmdb_app/features/popular_person_details/domain/usecases/get_popular_person_tvShows_usecase.dart';
import 'package:tmdb_app/features/popular_person_details/domain/usecases/store_popular_person_details_usecase.dart';

part 'popular_person_details_event.dart';

part 'popular_person_details_state.dart';

class PopularPersonDetailsBloc
    extends Bloc<PopularPersonDetailsEvent, PopularPersonDetailsState> {
  final GetPopularPersonDetailsUseCase getPopularPersonDetailsUseCase;
  final GetPopularPersonImagesUseCase getPopularPersonImagesUseCase;
  final GetPopularPersonMoviesUseCase getPopularPersonMoviesUseCase;
  final GetPopularPersonTVShowsUseCase getPopularPersonTVShowsUseCase;
  final StorePopularPersonDetailsUseCase storePopularPersonDetailsUseCase;
  final GetLocalPopularPersonDetailsUseCase getLocalPopularPersonDetailsUseCase;

  PopularPersonDetailsBloc(
      this.getPopularPersonDetailsUseCase,
      this.getPopularPersonImagesUseCase,
      this.getPopularPersonMoviesUseCase,
      this.getPopularPersonTVShowsUseCase,
      this.storePopularPersonDetailsUseCase,
      this.getLocalPopularPersonDetailsUseCase)
      : super(PopularPersonDetailsState()) {
    on<GetPopularPersonDetails>(_getPopularPersonDetails);
    on<GetPopularPersonImages>(_getPopularPersonImages);
    on<GetPopularPersonLocalImages>(_getPopularPersonLocalImages);
    on<GetPopularPersonMovies>(_getPopularPersonMovies);
    on<GetPopularPersonLocalMovies>(_getPopularPersonLocalMovies);
    on<GetPopularPersonTVShows>(_getPopularPersonTVShows);
    on<GetPopularPersonLocalTVShows>(_getPopularPersonLocalTVShows);
    on<GetLocalPopularPersonDetails>(_getLocalPopularPersonDetails);
  }

  FutureOr<void> _getPopularPersonDetails(GetPopularPersonDetails event,
      Emitter<PopularPersonDetailsState> emit) async {
    debugPrint(
        "_getPopularPersonDetails RequestState.loading ${event.personId}");

    emit(state.copyWith(
      requestState: RequestState.loading,
    ));

    debugPrint("_getPopularPersonDetails ${event.personId}");

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
          popularPersonDetailsEntity: r,
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
          popularPersonDetailsEntity: r,
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

  FutureOr<void> _getPopularPersonImages(GetPopularPersonImages event,
      Emitter<PopularPersonDetailsState> emit) async {
    debugPrint("_getPopularPersonImages RequestState.loading");

    emit(state.copyWith(
      requestStateImages: RequestState.loading,
    ));

    final result = await getPopularPersonImagesUseCase(
        GetPopularPersonImagesParameters(state.popularPersonDetailsEntity!));

    result.fold((l) {
      debugPrint("left getPopularPersonImages $l");
      return emit(state.copyWith(
        requestStateImages: RequestState.error,
        errorMessage: l.failureMessage,
        dataSource: DataSource.remote,
      ));
    }, (r) {
      if (r != null) {
        debugPrint("right getPopularPersonImages $r");
        storePopularPersonDetailsUseCase(
            StorePopularPersonDetailsParameters(r));
        return emit(state.copyWith(
          popularPersonDetailsEntity: r,
          requestStateImages: RequestState.loaded,
          errorMessage: "",
          dataSource: DataSource.remote,
        ));
      } else {
        return emit(state.copyWith(
          requestStateImages: RequestState.error,
          errorMessage: "No remote data",
          dataSource: DataSource.remote,
        ));
      }
    });
  }

  FutureOr<void> _getPopularPersonMovies(GetPopularPersonMovies event,
      Emitter<PopularPersonDetailsState> emit) async {
    debugPrint("_getPopularPersonMovies RequestState.loading");

    emit(state.copyWith(
      requestStateMovies: RequestState.loading,
    ));

    final result = await getPopularPersonMoviesUseCase(
        GetPopularPersonMoviesParameters(state.popularPersonDetailsEntity!));

    result.fold((l) {
      debugPrint("left getPopularPersonMovies $l");
      return emit(state.copyWith(
        requestStateMovies: RequestState.error,
        errorMessage: l.failureMessage,
        dataSource: DataSource.remote,
      ));
    }, (r) {
      if (r != null) {
        debugPrint("right getPopularPersonMovies $r");
        storePopularPersonDetailsUseCase(
            StorePopularPersonDetailsParameters(r));
        return emit(state.copyWith(
          popularPersonDetailsEntity: r,
          requestStateMovies: RequestState.loaded,
          errorMessage: "",
          dataSource: DataSource.remote,
        ));
      } else {
        return emit(state.copyWith(
          requestStateMovies: RequestState.error,
          errorMessage: "No remote data",
          dataSource: DataSource.remote,
        ));
      }
    });
  }

  FutureOr<void> _getPopularPersonTVShows(GetPopularPersonTVShows event,
      Emitter<PopularPersonDetailsState> emit) async {
    debugPrint("_getPopularPersonTVShows RequestState.loading");

    emit(state.copyWith(
      requestStateTVShows: RequestState.loading,
    ));

    final result = await getPopularPersonTVShowsUseCase(
        GetPopularPersonTVShowsParameters(state.popularPersonDetailsEntity!));

    result.fold((l) {
      debugPrint("left getPopularPersonTVShows $l");
      return emit(state.copyWith(
        requestStateTVShows: RequestState.error,
        errorMessage: l.failureMessage,
        dataSource: DataSource.remote,
      ));
    }, (r) {
      if (r != null) {
        debugPrint("right getPopularPersonTVShows $r");
        storePopularPersonDetailsUseCase(
            StorePopularPersonDetailsParameters(r));
        return emit(state.copyWith(
          popularPersonDetailsEntity: r,
          requestStateTVShows: RequestState.loaded,
          errorMessage: "",
          dataSource: DataSource.remote,
        ));
      } else {
        return emit(state.copyWith(
          requestStateTVShows: RequestState.error,
          errorMessage: "No remote data",
          dataSource: DataSource.remote,
        ));
      }
    });
  }

  FutureOr<void> _getPopularPersonLocalImages(GetPopularPersonLocalImages event,
      Emitter<PopularPersonDetailsState> emit) async {
    await Future.delayed(Duration(milliseconds: 500));
    return emit(state.copyWith(
      requestStateImages: RequestState.loaded,
      dataSource: DataSource.local,
    ));
  }

  FutureOr<void> _getPopularPersonLocalMovies(GetPopularPersonLocalMovies event,
      Emitter<PopularPersonDetailsState> emit) async {
    await Future.delayed(Duration(milliseconds: 500));
    return emit(state.copyWith(
      requestStateMovies: RequestState.loaded,
      dataSource: DataSource.local,
    ));
  }

  FutureOr<void> _getPopularPersonLocalTVShows(
      GetPopularPersonLocalTVShows event,
      Emitter<PopularPersonDetailsState> emit) async {
    await Future.delayed(Duration(milliseconds: 500));
    return emit(state.copyWith(
      requestStateTVShows: RequestState.loaded,
      dataSource: DataSource.local,
    ));
  }
}
