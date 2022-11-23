import 'package:tmdb_app/data/local/person_db.dart';
import 'package:tmdb_app/data/service/api_service.dart';
import 'package:tmdb_app/features/popular_persons/data/data_source/local/popular_person_local_data_source.dart';
import 'package:tmdb_app/main.dart';
import 'package:tmdb_app/models/all_popular_persons/all_popular_persons.dart';

abstract class PopularPersonRemoteDataSource {
  Future<AllPopularPersons?> getPopularPerson({int page = 1});
}
