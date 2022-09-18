import 'package:flutter/material.dart';
import 'package:tmdb_app/modules/popular_persons/cubit/cubit.dart';
import 'package:tmdb_app/modules/popular_persons/widgets/popular_person_item.dart';

class PopularPersonsGridView extends StatelessWidget {
  final PopularPersonsCubit popularPersonsCubit;
  const PopularPersonsGridView({Key? key,
    required this.popularPersonsCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (scrollEnd) {
        final metrics = scrollEnd.metrics;
        if (metrics.atEdge) {
          bool isTop = metrics.pixels == 0;
          if (isTop) {
            print('At the top');
            popularPersonsCubit.onTopScroll();
          } else {
            print('At the bottom');
            popularPersonsCubit.onEndScroll();
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
          childCount: popularPersonsCubit.popularPersons!=null
              ?(popularPersonsCubit.popularPersons.length + 2) : 0,
              (context, index) {
            if (index >= popularPersonsCubit.popularPersons.length) {
              //show loading indicator at last index
              return popularPersonsCubit.loadingMore
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
              ) : const SizedBox();
            }
            return PopularPersonItem(popularPerson: popularPersonsCubit.popularPersons[index]);
          },
        ),
      ),
    );
  }
}
