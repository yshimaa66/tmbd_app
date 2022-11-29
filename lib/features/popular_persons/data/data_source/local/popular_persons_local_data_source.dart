import 'package:tmdb_app/features/popular_persons/data/models/all_popular_persons/all_popular_persons.dart';
import 'package:tmdb_app/features/popular_persons/domain/entities/all_popular_persons_entity.dart';

abstract class PopularPersonsLocalDataSource {
  AllPopularPersonsEntity? getAllLocalPopularPersons(int page);

  storeAllPopularPersons(AllPopularPersonsEntity allPopularPersonsEntity);
}
