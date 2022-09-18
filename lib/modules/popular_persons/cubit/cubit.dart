import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/data/api/api_service.dart';
import 'package:tmdb_app/data/local/person_db.dart';
import 'package:tmdb_app/data/repository/popular_person_repository.dart';
import 'package:tmdb_app/models/popular_person/popular_person.dart';
import 'package:tmdb_app/modules/popular_persons/cubit/states.dart';


class PopularPersonsCubit extends Cubit<PopularPersonsStates> {
  PopularPersonsCubit() : super(Initial());

  static PopularPersonsCubit get(context) => BlocProvider.of(context);

  final PopularPersonRepository popularPersonRepository = PopularPersonRepository(PersonDb(),ApiService());

  int currentPage = 1;

  bool loadingMore = false;

  bool getFirstData = false;
  bool lastPage = false;

  List<PopularPerson> popularPersons = [];

  getPopularPersons() async {
    toggleLoadingMore();
    try {
      final result = await popularPersonRepository.getPopularPerson(page: currentPage);
      debugPrint("$currentPage -> Last Page: ${result?.page}/${result?.totalPages}");
      if (result != null && currentPage == result.totalPages) {
        lastPage = true;
      }
      final bool emptyRepositories = result?.results == null;
      if (!getFirstData && emptyRepositories) {
        emit(PopularPersonsEmpty());
      } else {
        getFirstData = true;
        popularPersons = [...popularPersons, ...result?.results ?? []];
        emit(PopularPersonsSuccess());
      }
    } catch (e) {
      emit(PopularPersonsError(e.toString()));
    } finally {
      toggleLoadingMore();
    }
  }

  void loadMore(){
    debugPrint('loadMore');
    currentPage++;
    getPopularPersons();
  }

  refreshPopularPersons(){
    currentPage = 1;
    getPopularPersons();
  }

  toggleLoadingMore() {
    loadingMore = !loadingMore;
    emit(LoadingMore());
  }

  onEndScroll(){
    debugPrint('onEndScroll');
    if (!lastPage) {
      // loadingMore = true;
      toggleLoadingMore();
      loadMore();
    } else {
      debugPrint('lastPage');
      // loadingMore = false;
      toggleLoadingMore();
    }
  }

  onTopScroll(){
    debugPrint('onTopScroll');
  }


}
