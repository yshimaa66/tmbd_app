import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/data/local/person_db.dart';
import 'package:tmdb_app/data/repository/popular_person_repository.dart';
import 'package:tmdb_app/data/service/api_service.dart';
import 'package:tmdb_app/modules/popular_person_details/cubit/states.dart';

class PopularPersonDetailsCubit extends Cubit<PopularPersonDetailsStates> {
  PopularPersonDetailsCubit() : super(Initial());

  static PopularPersonDetailsCubit get(context) => BlocProvider.of(context);

  bool loadingDetails = false;

  final PopularPersonRepository popularPersonRepository = PopularPersonRepository(PersonDb(),ApiService());

  getPopularPersonDetail(int personId) async {
    if(personId!=-1){
    toggleLoadingDetails();
    try {
      await popularPersonRepository.getPopularPersonDetail(
        personId: personId,
      ).onError((error, stackTrace){
        emit(PopularPersonDetailsError(error.toString()));
      }).then((value){
        emit(PopularPersonDetailsSuccess(value));
      });
    } catch (e) {
      emit(PopularPersonDetailsError(e.toString()));
    } finally {
      toggleLoadingDetails();
    }}else{
      emit(PopularPersonDetailsError("Popular Person ID Not Found"));
    }
  }

  toggleLoadingDetails() {
    loadingDetails = !loadingDetails;
    emit(LoadingDetails());
  }


}
