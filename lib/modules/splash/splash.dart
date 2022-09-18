import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tmdb_app/modules/popular_persons/popular_persons.dart';
import 'package:tmdb_app/shared/navigation.dart';
import 'package:tmdb_app/utilities/index.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      debugPrint('delayed execution');
      navigateAndReplacement(context, const PopularPersonsScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
          child: Hero(
            tag: appIconTransparent,
            child: SvgPicture.asset(
              appIconTransparent,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}
