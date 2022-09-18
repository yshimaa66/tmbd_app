import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/modules/popular_persons/cubit/cubit.dart';
import 'package:tmdb_app/modules/popular_persons/cubit/states.dart';
import 'package:tmdb_app/modules/popular_persons/widgets/error_message_widget.dart';
import 'package:tmdb_app/modules/popular_persons/widgets/popular_persons_grid_view.dart';
import 'widgets/popular_person_item.dart';


class PopularPersonsScreen extends StatefulWidget {
  const PopularPersonsScreen({Key? key}) : super(key: key);

  @override
  State<PopularPersonsScreen> createState() => _PopularPersonsScreenState();
}

class _PopularPersonsScreenState extends State<PopularPersonsScreen> {
  late PopularPersonsCubit popularPersonsCubit;

  bool? isSuccess;
  String errorStr = "";

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    Widget getBodyWidget(){
      if(isSuccess==null){
        // still fetch data
        return const Center(child: CircularProgressIndicator());
      }
      else{
      if(isSuccess!){
        if(popularPersonsCubit.popularPersons.isNotEmpty){
          return PopularPersonsGridView(popularPersonsCubit: popularPersonsCubit,);
        }
        else{
          return ErrorMessageWidget(btnText:"Refresh",
              textStr:'No Popular Person Found',
              onPressed:popularPersonsCubit.refreshPopularPersons());
        }
      }
      else{
        return ErrorMessageWidget(btnText:"Retry",
            textStr:'Error: Cannot Get Popular Persons \n$errorStr',
            onPressed:popularPersonsCubit.refreshPopularPersons());
      }}
    }

    // TODO: implement build
    return BlocProvider<PopularPersonsCubit>(
        create: (context) => PopularPersonsCubit()..getPopularPersons(),
        child: BlocConsumer<PopularPersonsCubit, PopularPersonsStates>(
            listener: (context, state) async {

              if(state is PopularPersonsError){
                isSuccess = false;
                errorStr = state.error;
              }

              if(state is PopularPersonsSuccess){
                isSuccess = true;
              }

            },builder: (context, state){

          popularPersonsCubit = BlocProvider.of<PopularPersonsCubit>(context);
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Popular Persons'),
              ),
              body: getBodyWidget());
        }));
  }
}

