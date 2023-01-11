import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:tmdb_app/core/API/api_consumer.dart';
import 'package:tmdb_app/core/API/end_points.dart';
import 'package:tmdb_app/features/popular_person_details/data/data_source/remote/popular_person_details_RDS.dart';
import 'package:tmdb_app/features/popular_person_details/data/models/movie_credits.dart';
import 'package:tmdb_app/features/popular_person_details/data/models/other_images.dart';
import 'package:tmdb_app/features/popular_person_details/data/models/popular_person_details.dart';
import 'package:tmdb_app/features/popular_person_details/data/models/tv_credits.dart';

@LazySingleton(as: PopularPersonDetailsRemoteDataSource)
class PopularPersonDetailsRemoteDataSourceImpl
    implements PopularPersonDetailsRemoteDataSource {
  final ApiConsumer apiConsumer;

  PopularPersonDetailsRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<PopularPersonDetails?> getPopularPersonDetails(int personId) async {
    debugPrint("PopularPersonDetailsRemoteDataSourceImpl $personId");
    Map<String, dynamic> result = Map<String, dynamic>.from(
      await apiConsumer.get(
        EndPoints.peopleInfoUrl(personId.toString()),
      ),
    );
    final PopularPersonDetails popular = PopularPersonDetails.fromJson(result);
    debugPrint("PopularPersonDetailsRemoteDataSourceImpl $personId ${popular}");
    return popular;
  }

  @override
  Future<OtherImages?> getPopularPersonImages(int personId) async {
    debugPrint(
        "PopularPersonDetailsRemoteDataSourceImpl getPopularPersonImages $personId");
    Map<String, dynamic> result = Map<String, dynamic>.from(
      await apiConsumer.get(
        EndPoints.peopleImagesUrl(personId.toString()),
      ),
    );
    final OtherImages otherImages = OtherImages.fromJson(result);
    debugPrint(
        "PopularPersonDetailsRemoteDataSourceImpl getPopularPersonImages $personId ${otherImages.profiles!.first.toString()}");
    return otherImages;
  }

  @override
  Future<MovieCredits?> getPopularPersonMovies(int personId) async {
    debugPrint(
        "PopularPersonDetailsRemoteDataSourceImpl getPopularPersonMovies $personId");
    Map<String, dynamic> result = Map<String, dynamic>.from(
      await apiConsumer.get(
        EndPoints.peopleMoviesUrl(personId.toString()),
      ),
    );
    final MovieCredits movieCredits = MovieCredits.fromJson(result);
    debugPrint(
        "PopularPersonDetailsRemoteDataSourceImpl getPopularPersonMovies $personId ${movieCredits.cast!.first}");
    return movieCredits;
  }

  @override
  Future<TVCredits?> getPopularPersonTVShows(int personId) async {
    debugPrint(
        "PopularPersonDetailsRemoteDataSourceImpl getPopularPersonTVShows $personId");
    Map<String, dynamic> result = Map<String, dynamic>.from(
      await apiConsumer.get(
        EndPoints.peopleTVShowsUrl(personId.toString()),
      ),
    );
    final TVCredits tvCredits = TVCredits.fromJson(result);
    debugPrint(
        "PopularPersonDetailsRemoteDataSourceImpl getPopularPersonTVShows $personId ${tvCredits.cast!.first}");
    return tvCredits;
  }
}
