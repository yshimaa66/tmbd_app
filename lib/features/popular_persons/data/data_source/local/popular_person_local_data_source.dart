import 'package:get_storage/get_storage.dart';
import 'package:tmdb_app/models/all_popular_persons/all_popular_persons.dart';

final _box = GetStorage();

abstract class PopularPersonLocalDataSource {
  AllPopularPersons? getAllPopularPersons(int page);
  storeAllPopularPersons(AllPopularPersons allPopularPersons);
}
