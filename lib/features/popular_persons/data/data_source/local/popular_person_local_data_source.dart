import 'package:get_storage/get_storage.dart';
import 'package:tmdb_app/models/all_popular_persons/all_popular_persons.dart';

abstract class PopularPersonsLocalDataSource {
  AllPopularPersons? getAllLocalPopularPersons(int page);

  storeAllPopularPersons(AllPopularPersons allPopularPersons);
}
