import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/modules/main/cubit/states.dart';
import 'package:tmdb_app/shared/toast.dart';


class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(Initial());

  StreamSubscription? subscription;

  bool internetAvailable = true;

  void getInternetStatus() async {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      // Got a new connectivity status!
      debugPrint("result $result");
      if (result == ConnectivityResult.none) {
        internetAvailable = false;
        showToastMessage("You are offline !");
      } else {
        if(!internetAvailable){
          internetAvailable = true;
          showToastMessage("Back online !");
        }
      }
      emit(GetInternetStatus());
    });
    subscription?.resume();
  }


  void onClose() {
    subscription?.cancel();
  }


}
