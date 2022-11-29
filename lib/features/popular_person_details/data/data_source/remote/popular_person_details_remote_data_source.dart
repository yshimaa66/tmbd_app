import 'package:tmdb_app/features/popular_person_details/data/models/popular_person_details.dart';

abstract class PopularPersonDetailsRemoteDataSource {
  Future<PopularPersonDetails?> getPopularPersonDetails(int personId);
}
