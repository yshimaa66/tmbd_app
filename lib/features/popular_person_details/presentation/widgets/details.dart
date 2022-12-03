import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/core/utils/app_strings.dart';
import 'package:tmdb_app/core/utils/enums.dart';
import 'package:tmdb_app/features/popular_person_details/domain/entities/popular_person_details_entity.dart';
import 'package:tmdb_app/features/popular_person_details/presentation/bloc/popular_person_details_bloc.dart';
import 'package:tmdb_app/features/popular_person_details/presentation/widgets/about.dart';
import 'package:tmdb_app/features/popular_person_details/presentation/widgets/credit.dart';
import 'package:tmdb_app/features/popular_person_details/presentation/widgets/images.dart';
import 'package:tmdb_app/features/popular_person_details/presentation/widgets/sliver_app_bar_delegate.dart';
import 'package:tmdb_app/features/popular_person_details/presentation/widgets/text_container.dart';
import 'package:tmdb_app/features/popular_persons/presentation/widgets/error_message_widget.dart';
import 'package:tmdb_app/utilities/index.dart';

class Details extends StatelessWidget {
  final PopularPersonDetailsEntity popularPersonDetailsEntity;

  const Details({Key? key, required this.popularPersonDetailsEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late PopularPersonDetailsBloc popularPersonDetailsBloc;
    int tabIndexVal = 0;
    return BlocBuilder<PopularPersonDetailsBloc, PopularPersonDetailsState>(
        buildWhen: (previousState, nextState) =>
            (previousState.requestStateImages !=
                nextState.requestStateImages) ||
            (previousState.requestStateMovies !=
                nextState.requestStateMovies) ||
            (previousState.requestStateTVShows !=
                nextState.requestStateTVShows),
        builder: (context, state) {
          popularPersonDetailsBloc =
              BlocProvider.of<PopularPersonDetailsBloc>(context);
          return DefaultTabController(
            length: 4,
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: 280.0,
                    floating: false,
                    pinned: true,
                    title: Text(AppStrings.personInfoScreenTitle(
                        popularPersonDetailsEntity.name!)),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
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
                              Colors.white.withOpacity(0.3),
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
                                        "https://image.tmdb.org/t/p/w500${popularPersonDetailsEntity.profilePath}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "${popularPersonDetailsEntity.name}",
                                style: customTextStyleTitle.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomTextContainer(
                                    text:
                                        "${popularPersonDetailsEntity.knownForDepartment}",
                                    textColor: Theme.of(context).primaryColor,
                                  ),
                                  // const SizedBox(width: 8),
                                  CustomTextContainer(
                                    text:
                                        "${popularPersonDetailsEntity.popularity} Known Credits",
                                    textColor: Colors.white54,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    delegate: SliverAppBarDelegate(
                      TabBar(
                        labelColor:
                            Theme.of(context).textTheme.bodyText1?.color,
                        labelStyle:
                            const TextStyle(fontWeight: FontWeight.w800),
                        unselectedLabelColor: Colors.grey,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: Theme.of(context).backgroundColor,
                        indicatorWeight: 10,
                        isScrollable: true,
                        onTap: (int tabIndex) {
                          tabIndexVal = tabIndex;
                          debugPrint("tabIndex $tabIndex");
                          if (tabIndex == 1) {
                            //images
                            if (state
                                .popularPersonDetailsEntity!.images!.isEmpty) {
                              popularPersonDetailsBloc
                                  .add(GetPopularPersonImages());
                            } else {
                              popularPersonDetailsBloc
                                  .add(GetPopularPersonLocalImages());
                            }
                          } else if (tabIndex == 2) {
                            //movies
                            if (state.popularPersonDetailsEntity!
                                .movieCreditCasts!.isEmpty) {
                              popularPersonDetailsBloc
                                  .add(GetPopularPersonMovies());
                            } else {
                              popularPersonDetailsBloc
                                  .add(GetPopularPersonLocalMovies());
                            }
                          } else if (tabIndex == 3) {
                            //tv shows
                            if (state.popularPersonDetailsEntity!.tvCreditCasts!
                                .isEmpty) {
                              popularPersonDetailsBloc
                                  .add(GetPopularPersonTVShows());
                            } else {
                              popularPersonDetailsBloc
                                  .add(GetPopularPersonLocalTVShows());
                            }
                          }
                        },
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
                  AboutWidget(
                      popularPersonDetailsEntity: popularPersonDetailsEntity),
                  getTabBarView(
                      ImagesWidget(
                          images: state.popularPersonDetailsEntity!.images),
                      popularPersonDetailsBloc,
                      state.requestStateImages,
                      tabIndexVal),
                  getTabBarView(
                      CreditWidget(
                          castsEntity: state
                              .popularPersonDetailsEntity!.movieCreditCasts),
                      popularPersonDetailsBloc,
                      state.requestStateMovies,
                      tabIndexVal),
                  getTabBarView(
                      CreditWidget(
                          castsEntity:
                              state.popularPersonDetailsEntity!.tvCreditCasts),
                      popularPersonDetailsBloc,
                      state.requestStateTVShows,
                      tabIndexVal),
                ],
              ),
            ),
          );
        });
  }

  getTabBarView(
      Widget defaultWidget,
      PopularPersonDetailsBloc popularPersonDetailsBloc,
      RequestState state,
      int tabIndex) {
    String tabIndexStr = getTabIndexStr(tabIndex);
    switch (state) {
      case RequestState.error:
        return ErrorMessageWidget(
            btnText: "Retry",
            textStr: 'Error: Cannot Get $tabIndexStr',
            onPressed: () {
              popularPersonDetailsBloc.add(tabIndex == 1
                  ? GetPopularPersonImages()
                  : tabIndex == 2
                      ? GetPopularPersonMovies()
                      : GetPopularPersonTVShows());
            });
      case RequestState.loading:
        return const Center(child: CircularProgressIndicator());
      case RequestState.loaded:
        return defaultWidget;
    }
  }

  getTabIndexStr(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return "About";
      case 1:
        return "Images";
      case 2:
        return "Movies";
      case 3:
        return "TV Shows";
    }
  }
}
