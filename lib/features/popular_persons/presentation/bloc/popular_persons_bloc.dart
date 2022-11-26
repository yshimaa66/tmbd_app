import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tmdb_app/core/utils/enums.dart';
import 'package:tmdb_app/features/popular_persons/data/models/popular_person/popular_person.dart';
import 'package:tmdb_app/features/popular_persons/domain/usecases/get_popular_persons_usecase.dart';

part 'popular_persons_event.dart';

part 'popular_persons_state.dart';

class PopularPersonsBloc
    extends Bloc<PopularPersonsEvent, PopularPersonsState> {
  PopularPersonsBloc(this.getPopularPersonsUseCase)
      : super(PopularPersonsState()) {
    on<GetPopularPersons>(_getPopularPersons);
    on<LoadMore>(_loadMore);
    on<RefreshPopularPersons>(_refreshPopularPersons);
    on<OnEndScroll>(_onEndScroll);
  }

  final GetPopularPersonsUseCase getPopularPersonsUseCase;

  FutureOr<void> _getPopularPersons(
      GetPopularPersons event, Emitter<PopularPersonsState> emit) async {
    emit(state.copyWith(
      requestState: RequestState.loading,
    ));

    final result = await getPopularPersonsUseCase(
        PopularPersonsParameters(event.currentPage));

    result.fold((l) {
      return emit(state.copyWith(
          requestState: RequestState.error, errorMessage: l.message));
    }, (r) {
      List<PopularPerson>? newPopularPersons = state.popularPersons;
      newPopularPersons.addAll(r!.results!);
      return emit(state.copyWith(
          requestState: RequestState.loaded,
          popularPersons: newPopularPersons,
          lastPage: event.currentPage == r.totalPages,
          getFirstData: true));
    });
  }

  FutureOr<void> _loadMore(LoadMore event, Emitter<PopularPersonsState> emit) {
    emit(state.copyWith(currentPage: state.currentPage + 1, loadingMore: true));
  }

  FutureOr<void> _refreshPopularPersons(
      RefreshPopularPersons event, Emitter<PopularPersonsState> emit) {
    emit(state.copyWith(currentPage: 1, loadingMore: true));
  }

  FutureOr<void> _onEndScroll(
      OnEndScroll event, Emitter<PopularPersonsState> emit) {
    if (!state.lastPage) {
      emit(state.copyWith(
          currentPage: state.currentPage + 1, loadingMore: true));
    } else {
      debugPrint('lastPage');
      emit(state.copyWith(
          requestState: RequestState.loaded, loadingMore: false));
    }
  }
}
