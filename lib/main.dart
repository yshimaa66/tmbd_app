import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:tmdb_app/modules/main/cubit/cubit.dart';
import 'package:tmdb_app/modules/main/cubit/states.dart';
import 'package:tmdb_app/modules/splash/splash.dart';
import 'package:tmdb_app/utilities/index.dart';

late MainCubit mainCubit;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Plugin must be initialized before using
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);

  await GetStorage.init();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainCubit>(
        create: (context) => MainCubit()
          ..getInternetStatus(),
        child: BlocConsumer<MainCubit, MainStates>(
            listener: (context, state) async {



            },builder: (context, state){
          mainCubit = BlocProvider.of<MainCubit>(context);
          return OKToast(
            child: MaterialApp(
              title: appName,
              debugShowCheckedModeBanner: false,
              home: const SplashScreen(),
              theme: theme(context),
              darkTheme: darkTheme(context),
              builder: (context, widget) => ResponsiveWrapper.builder(
                BouncingScrollWrapper.builder(context, widget!),
                maxWidth: 1200,
                minWidth: 450,
                defaultScale: true,
                breakpoints: const[
                  ResponsiveBreakpoint.resize(480, name: MOBILE),
                  ResponsiveBreakpoint.autoScale(800, name: TABLET),
                  ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                ],
              ),
            ),
          );}));
  }
}