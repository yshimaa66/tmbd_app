import 'package:tmdb_app/features/popular_person_details/data/models/movie_credits.dart';
import 'package:tmdb_app/features/popular_person_details/data/models/other_images.dart';
import 'package:tmdb_app/features/popular_person_details/data/models/popular_person_details.dart';
import 'package:tmdb_app/features/popular_person_details/data/models/tv_credits.dart';

abstract class PopularPersonDetailsRemoteDataSource {
  Future<PopularPersonDetails?> getPopularPersonDetails(int personId);

  Future<OtherImages?> getPopularPersonImages(int personId);

  Future<MovieCredits?> getPopularPersonMovies(int personId);

  Future<TVCredits?> getPopularPersonTVShows(int personId);
}
