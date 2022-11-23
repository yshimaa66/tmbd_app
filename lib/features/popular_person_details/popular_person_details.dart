import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/models/popular_person/popular_person.dart';
import 'package:tmdb_app/features/popular_person_details/cubit/cubit.dart';
import 'package:tmdb_app/features/popular_person_details/cubit/states.dart';
import 'package:tmdb_app/features/popular_person_details/widgets/credit.dart';
import 'package:tmdb_app/features/popular_person_details/widgets/details.dart';
import 'package:tmdb_app/features/popular_person_details/widgets/images.dart';
import 'package:tmdb_app/features/popular_person_details/widgets/sliver_app_bar_delegate.dart';
import 'package:tmdb_app/features/popular_person_details/widgets/text_container.dart';
import 'package:tmdb_app/features/popular_persons/widgets/error_message_widget.dart';
import 'package:tmdb_app/utilities/index.dart';
import 'widgets/about.dart';

class PopularPersonsDetailsScreen extends StatefulWidget {
  final int popularPersonId;
  const PopularPersonsDetailsScreen({Key? key,
    this.popularPersonId=-1}) : super(key: key);

  @override
  State<PopularPersonsDetailsScreen> createState() => _PopularPersonsDetailsScreenState();
}

class _PopularPersonsDetailsScreenState extends State<PopularPersonsDetailsScreen> {

  late PopularPersonDetailsCubit popularPersonDetailsCubit;

  bool? isSuccess;
  String errorStr = "";

  PopularPerson? popularPerson;

  @override
  Widget build(BuildContext context) {

    Widget getBodyWidget(){
      if(popularPersonDetailsCubit.loadingDetails){
        return const Center(child: CircularProgressIndicator());
      }
      else if(!(isSuccess!) || popularPerson==null){
        return ErrorMessageWidget(
            textStr: 'Error: Cannot get Person Details \n$errorStr',
            btnText: 'Retry',
            onPressed: popularPersonDetailsCubit.getPopularPersonDetail(widget.popularPersonId));
      }else{
        return Details(popularPerson: popularPerson!);
      }
    }


    return BlocProvider<PopularPersonDetailsCubit>(
        create: (context) => PopularPersonDetailsCubit()
          ..getPopularPersonDetail(widget.popularPersonId),
        child: BlocConsumer<PopularPersonDetailsCubit, PopularPersonDetailsStates>(
            listener: (context, state) async {

              if(state is PopularPersonDetailsError){
                isSuccess = false;
                errorStr = state.error;
              }

              if(state is PopularPersonDetailsSuccess){
                isSuccess = true;
                popularPerson = state.person;
              }

            },builder: (context, state){

          popularPersonDetailsCubit = BlocProvider.of<PopularPersonDetailsCubit>(context);
          return Scaffold(
              body: getBodyWidget(),
            );
          }));
  }
}



