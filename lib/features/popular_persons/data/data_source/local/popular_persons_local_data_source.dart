import 'package:tmdb_app/features/popular_persons/data/models/all_popular_persons/all_popular_persons.dart';

abstract class PopularPersonsLocalDataSource {
  AllPopularPersons? getAllLocalPopularPersons(int page);

  storeAllPopularPersons(AllPopularPersons allPopularPersons);
}
