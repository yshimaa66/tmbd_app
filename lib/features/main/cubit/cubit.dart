import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/features/main/cubit/states.dart';
import 'package:tmdb_app/shared/toast.dart';


class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(Initial());

  StreamSubscription? subscription;

  bool internetAvailable = false;

  bool wasOffline = false;

  void getInternetStatus() async {
    debugPrint("getInternetStatus()");
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      // Got a new connectivity status!
      debugPrint("getInternetStatus $result");
      if (result == ConnectivityResult.none) {
        internetAvailable = false;
        wasOffline = true;
        showToastMessage("You are offline !",Colors.red);
      } else {
        if(wasOffline){
          showToastMessage("Back online !",Colors.green);
        }
        internetAvailable = true;
        wasOffline = false;
      }
      emit(GetInternetStatus());
    });
    subscription?.resume();
  }


  void onClose() {
    subscription?.cancel();
  }


}
