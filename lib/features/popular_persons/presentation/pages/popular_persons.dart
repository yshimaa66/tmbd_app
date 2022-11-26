import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/core/utils/enums.dart';
import 'package:tmdb_app/features/popular_persons/presentation/bloc/popular_persons_bloc.dart';
import 'package:tmdb_app/features/popular_persons/presentation/widgets/error_message_widget.dart';
import 'package:tmdb_app/features/popular_persons/presentation/widgets/popular_persons_grid_view.dart';

class PopularPersonsScreen extends StatefulWidget {
  const PopularPersonsScreen({Key? key}) : super(key: key);

  @override
  State<PopularPersonsScreen> createState() => _PopularPersonsScreenState();
}

class _PopularPersonsScreenState extends State<PopularPersonsScreen> {

  @override
  Widget build(BuildContext context) {
    Widget getBodyWidget(PopularPersonsState state) {
      switch (state.requestState) {
        case RequestState.error:
          return ErrorMessageWidget(
              btnText: "Retry",
              textStr: 'Error: Cannot Get Popular Persons \n${state.errorMessage}',
              onPressed: popularPersonsBloc.refreshPopularPersons()
          );
        case RequestState.loaded:
          if(state.popularPersons.isEmpty){
            return ErrorMessageWidget(
                btnText: "Refresh",
                textStr: 'No Popular Person Found',
                onPressed: popularPersonsBloc.refreshPopularPersons());
          }
          return PopularPersonsGridView(
            popularPersonsBloc: popularPersonsBloc,
          );
        case RequestState.loading:
          return const Center(child: CircularProgressIndicator());
      }
    }

    // TODO: implement build
    return BlocProvider<PopularPersonsBloc>(
        create: (context) => PopularPersonsBloc()..getPopularPersons(),
        child: BlocConsumer<PopularPersonsBloc, PopularPersonsState>(
            listener: (context, state) async {},
            buildWhen: (previousState, currentState) =>
                previousState.requestState != currentState.requestState,
            builder: (context, state) {
              PopularPersonsBloc popularPersonsBloc =
                  BlocProvider.of<PopularPersonsBloc>(context);
              return Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text(
                      'Popular Persons',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  body: getBodyWidget(state));
            }));
  }
}
