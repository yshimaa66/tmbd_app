import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/models/popular_person/popular_person.dart';
import 'package:tmdb_app/modules/popular_person_details/cubit/cubit.dart';
import 'package:tmdb_app/modules/popular_person_details/cubit/states.dart';
import 'package:tmdb_app/modules/popular_persons/widgets/credit.dart';
import 'package:tmdb_app/modules/popular_persons/widgets/images.dart';
import 'package:tmdb_app/modules/popular_persons/widgets/text_container.dart';
import 'package:tmdb_app/utilities/index.dart';
import 'widgets/about_popular_person.dart';

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

  PopularPerson? person;

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    Widget getBodyWidget(){
      if(popularPersonDetailsCubit.loadingDetails){
        return const Center(child: CircularProgressIndicator());
      }
      else if(!(isSuccess!)){
        return Center(child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Error: Cannot get Person Details \n$errorStr',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: popularPersonDetailsCubit.getPopularPersonDetail(widget.popularPersonId),
              child: const Text('Retry'),
            ),
          ],
        ),);
      }else{
        return DefaultTabController(
          length: 4,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 280.0,
                  floating: false,
                  pinned: true,
                  title: Text("${person?.name}"),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              imageUrl:
                              "https://image.tmdb.org/t/p/w500${person?.profilePath}",
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                            boxShadow: const [
                              BoxShadow(color: Colors.black12, spreadRadius: 0.5),
                            ],
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.3),
                                Colors.black.withOpacity(1),
                              ],
                              begin: Alignment.center,
                              stops: const [0, 1],
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      "https://image.tmdb.org/t/p/w500${person?.profilePath}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "${person?.name}",
                                  style: customTextStyleTitle.copyWith(
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomTextContainer(
                                      text: "${person?.knownForDepartment}",
                                      textColor: Theme.of(context).primaryColor,
                                    ),
                                    // const SizedBox(width: 8),
                                    CustomTextContainer(
                                      text: "${person?.popularity} Known Credits",
                                      textColor: Colors.white54,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      labelColor: Theme.of(context).textTheme.bodyText1?.color,
                      unselectedLabelColor: Colors.grey,
                      indicatorSize: TabBarIndicatorSize.label,
                      isScrollable: true,
                      tabs: const [
                        Tab(text: "About"),
                        Tab(text: "Images"),
                        Tab(text: "Movies"),
                        Tab(text: "TV Shows"),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
                  children: [
                    AboutPersonWidget(person: person),
                    PopularPersonImagesWidget(images: person?.otherImages),
                    PopularPersonCreditWidget(casts: person?.movieCasts),
                    PopularPersonCreditWidget(casts: person?.tvCasts),
                  ],
              ),
            ),
        );
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
                person = state.person;
              }

            },builder: (context, state){

          popularPersonDetailsCubit = BlocProvider.of<PopularPersonDetailsCubit>(context);
          return Scaffold(
              body: getBodyWidget(),
            );
          }));
  }
}


class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
