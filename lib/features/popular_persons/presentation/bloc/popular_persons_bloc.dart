import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/core/utils/enums.dart';
import 'package:tmdb_app/features/popular_persons/data/models/popular_person/popular_person.dart';
import 'package:tmdb_app/features/popular_persons/domain/entities/popular_person_entity.dart';
import 'package:tmdb_app/features/popular_persons/domain/usecases/get_local_popular_persons_usecase.dart';
import 'package:tmdb_app/features/popular_persons/domain/usecases/get_popular_persons_usecase.dart';
import 'package:tmdb_app/features/popular_persons/domain/usecases/store_popular_persons_usecase.dart';

part 'popular_persons_event.dart';

part 'popular_persons_state.dart';

class PopularPersonsBloc
    extends Bloc<PopularPersonsEvent, PopularPersonsState> {
  final GetPopularPersonsUseCase getPopularPersonsUseCase;
  final StorePopularPersonsUseCase storePopularPersonsUseCase;
  final GetLocalPopularPersonsUseCase getLocalPopularPersonsUseCase;

  PopularPersonsBloc(this.getPopularPersonsUseCase,
      this.storePopularPersonsUseCase, this.getLocalPopularPersonsUseCase)
      : super(PopularPersonsState()) {
    on<GetPopularPersons>(_getPopularPersons);
    on<LoadMore>(_loadMore);
    on<RefreshPopularPersons>(_refreshPopularPersons);
    on<OnEndScroll>(_onEndScroll);
    on<GetLocalPopularPersons>(_getLocalPopularPersons);
  }

  FutureOr<void> _getPopularPersons(
      GetPopularPersons event, Emitter<PopularPersonsState> emit) async {
    emit(state.copyWith(
      requestState: RequestState.loading,
    ));

    final result = await getPopularPersonsUseCase(
        GetPopularPersonsParameters(state.currentPage));

    result.fold((l) {
      debugPrint("left getPopularPersons $l");
      return emit(state.copyWith(
          requestState: RequestState.error,
          errorMessage: l.failureMessage,
          isRefreshing: false,
          loadingMore: false,
          dataSource: DataSource.remote,
          getFirstData: state.currentPage == 1));
    }, (r) {
      // TODO : implement entity
      if (r != null) {
        debugPrint("right getPopularPersons $r");
        storePopularPersonsUseCase(StorePopularPersonsParameters(r));
        List<PopularPersonEntity>? allPopularPersons = [];
        allPopularPersons = [...state.popularPersons, ...r.results ?? []];
        final bool lastPage = (state.currentPage == r.totalPages);
        return emit(state.copyWith(
            requestState: RequestState.loaded,
            loadingMore: false,
            isRefreshing: false,
            popularPersons: allPopularPersons,
            lastPage: lastPage,
            errorMessage: "",
            dataSource: DataSource.remote,
            getFirstData: state.currentPage == 1));
      } else {
        return emit(state.copyWith(
            requestState: RequestState.loaded,
            errorMessage: "No remote data",
            isRefreshing: false,
            loadingMore: false,
            dataSource: DataSource.remote,
            getFirstData: state.currentPage == 1));
      }
    });
  }

  FutureOr<void> _loadMore(LoadMore event, Emitter<PopularPersonsState> emit) {
    final int currentPage = state.currentPage + 1;
    emit(state.copyWith(currentPage: currentPage, loadingMore: true));
  }

  FutureOr<void> _refreshPopularPersons(
      RefreshPopularPersons event, Emitter<PopularPersonsState> emit) {
    PopularPersonsState state = PopularPersonsState(isRefreshing: true);
    emit(state);
  }

  FutureOr<void> _onEndScroll(
      OnEndScroll event, Emitter<PopularPersonsState> emit) {
    if (!state.lastPage) {
      final int currentPage = state.currentPage + 1;
      emit(state.copyWith(
          loadingMore: true,
          currentPage: currentPage,
          isRefreshing: false,
          getFirstData: false));
    } else {
      debugPrint('lastPage');
      emit(state.copyWith(
          requestState: RequestState.loaded,
          loadingMore: false,
          isRefreshing: false,
          getFirstData: false));
    }
  }

  FutureOr<void> _getLocalPopularPersons(
      GetLocalPopularPersons event, Emitter<PopularPersonsState> emit) async {
    final result = await getLocalPopularPersonsUseCase(
        GetLocalPopularPersonsParameters(state.currentPage));
    result.fold((l) {
      debugPrint("left getLocalPopularPersons $l");
      return emit(state.copyWith(
          requestState: RequestState.error,
          errorMessage: l.failureMessage,
          isRefreshing: false,
          loadingMore: false,
          dataSource: DataSource.local,
          getFirstData: state.currentPage == 1));
    }, (r) async {
      // TODO : implement entity
      if (r != null) {
        List<PopularPersonEntity>? allPopularPersons = [];
        allPopularPersons = [...state.popularPersons, ...r.results ?? []];
        debugPrint("_getLocalPopularPersons $r");
        final bool lastPage = (state.currentPage == r.totalPages);
        return emit(state.copyWith(
            requestState: RequestState.loaded,
            loadingMore: false,
            isRefreshing: false,
            popularPersons: allPopularPersons,
            lastPage: lastPage,
            errorMessage: "",
            dataSource: DataSource.local,
            getFirstData: state.currentPage == 1));
      } else {
        return emit(state.copyWith(
            requestState: RequestState.loaded,
            errorMessage: "No local data",
            loadingMore: false,
            isRefreshing: false,
            dataSource: DataSource.local,
            getFirstData: state.currentPage == 1));
      }
    });
  }
}
