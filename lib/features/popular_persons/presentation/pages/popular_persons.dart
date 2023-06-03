import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/core/services/injection.dart';
import 'package:tmdb_app/core/utils/app_strings.dart';
import 'package:tmdb_app/core/utils/enums.dart';
import 'package:tmdb_app/features/popular_persons/domain/usecases/get_local_popular_persons_usecase.dart';
import 'package:tmdb_app/features/popular_persons/domain/usecases/get_popular_persons_usecase.dart';
import 'package:tmdb_app/features/popular_persons/domain/usecases/store_popular_persons_usecase.dart';
import 'package:tmdb_app/features/popular_persons/presentation/bloc/popular_persons_bloc.dart';
import 'package:tmdb_app/features/popular_persons/presentation/widgets/error_message_widget.dart';
import 'package:tmdb_app/features/popular_persons/presentation/widgets/popular_persons_grid_view.dart';

class PopularPersonsScreen extends StatelessWidget {
  const PopularPersonsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late PopularPersonsBloc popularPersonsBloc;

    Widget getBodyWidget(PopularPersonsState state) {
      debugPrint("PopularPersonState ${state}");
      if (state.getFirstData) {
        switch (state.requestState) {
          case RequestState.error:
            return ErrorMessageWidget(
                btnText: "Retry",
                textStr:
                    'Error: Cannot Get Popular Persons \n${state.errorMessage}',
                onPressed: () {
                  popularPersonsBloc.add(RefreshPopularPersons());
                });
          case RequestState.loaded:
            if (state.popularPersons.isEmpty) {
              return ErrorMessageWidget(
                  btnText: "Refresh",
                  textStr: 'No Popular Person Found',
                  onPressed: () {
                    popularPersonsBloc.add(RefreshPopularPersons());
                  });
            }
            return PopularPersonsGridView();
          case RequestState.loading:
            return const Center(child: CircularProgressIndicator());
        }
      }
      return PopularPersonsGridView();
    }

    return BlocProvider<PopularPersonsBloc>(
        create: (context) => PopularPersonsBloc(
            getIt<GetPopularPersonsUseCase>(),
            getIt<StorePopularPersonsUseCase>(),
            getIt<GetLocalPopularPersonsUseCase>())
          ..add(GetPopularPersons()),
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                AppStrings.popularPeopleScreenTitle,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            body: BlocConsumer<PopularPersonsBloc, PopularPersonsState>(
              buildWhen: (previousState, nextState) =>
                  previousState.requestState != nextState.requestState,
              listener: (context, state) async {
                if (state.requestState == RequestState.error) {
                  if (state.dataSource == DataSource.remote) {
                    log("",name:"popularPersonsBloc.add(GetLocalPopularPersons()");
                    popularPersonsBloc.add(GetLocalPopularPersons());
                  }
                }
                if (state.isRefreshing) {
                  popularPersonsBloc.add(GetPopularPersons());
                }
              },
              builder: (context, state) {
                popularPersonsBloc =
                    BlocProvider.of<PopularPersonsBloc>(context);
                debugPrint("state.getFirstData ${state.getFirstData}");
                return getBodyWidget(state);
              },
            )));
  }
}
