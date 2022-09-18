import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/modules/main/cubit/states.dart';


class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(Initial());



}
