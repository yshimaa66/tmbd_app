import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/core/utils/enums.dart';
import 'package:tmdb_app/features/popular_persons/presentation/bloc/popular_persons_bloc.dart';
import 'package:tmdb_app/features/popular_persons/presentation/widgets/popular_person_item.dart';
import 'package:tmdb_app/features/popular_persons/presentation/widgets/snackBar_widget.dart';

class PopularPersonsGridView extends StatelessWidget {
  const PopularPersonsGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PopularPersonsBloc popularPersonsBloc =
        BlocProvider.of<PopularPersonsBloc>(context);
    return BlocConsumer<PopularPersonsBloc, PopularPersonsState>(
      listener: (context, state) {
        if(state.loadingMore){
          popularPersonsBloc.add(GetPopularPersons());
        }
      },
      builder: (context, state) {
        return Scaffold(
          bottomSheet: (state.errorMessage!="")?
          SnackBarWidget(btnText: "Retry",
            textStr: state.errorMessage,
            isLoading: state.requestState==RequestState.loading,
            onPressed: () {
              popularPersonsBloc.add(GetPopularPersons());
            }):const SizedBox(),
          body: NotificationListener<ScrollEndNotification>(
            onNotification: (scrollEnd) {
              final metrics = scrollEnd.metrics;
              if (metrics.atEdge) {
                bool isTop = metrics.pixels == 0;
                if (isTop) {
                  print('At the top');
                  popularPersonsBloc.add(RefreshPopularPersons());
                } else {
                  print('At the bottom');
                  popularPersonsBloc.add(OnEndScroll());
                }
              }
              return true;
            },
            child: GridView.custom(
              padding: const EdgeInsets.all(5),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              childrenDelegate: SliverChildBuilderDelegate(
                childCount: state.popularPersons.isNotEmpty
                    ? (state.popularPersons.length + 2)
                    : 0,
                (context, index) {
                  if (index >= state.popularPersons.length) {
                    //show loading indicator at last index
                    return state.loadingMore
                        ? Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey.withOpacity(0.1)),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            margin: const EdgeInsets.all(5),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : const SizedBox();
                  }
                  return PopularPersonItem(
                      popularPerson: state.popularPersons[index]);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
