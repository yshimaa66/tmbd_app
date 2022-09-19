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
    Future.delayed(const Duration(seconds: 5), () {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: appIconTransparent,
                child: Image.asset(
                  appIconTransparent,
                  fit: BoxFit.fitWidth,
                ),
              ),

              const SizedBox(height: 20,),

              Text('Popular Persons',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
    );
  }
}
