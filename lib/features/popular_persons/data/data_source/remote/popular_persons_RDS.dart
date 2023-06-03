import 'package:tmdb_app/features/popular_persons/data/models/all_popular_persons/all_popular_persons.dart';

abstract class PopularPersonsRemoteDataSource {
  Future<AllPopularPersons?> getAllPopularPersons({int page = 1});
}
