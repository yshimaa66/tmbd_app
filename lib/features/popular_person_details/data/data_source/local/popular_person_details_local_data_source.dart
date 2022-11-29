import 'package:tmdb_app/features/popular_person_details/data/models/popular_person_details.dart';
import 'package:tmdb_app/features/popular_person_details/domain/entities/popular_person_details_entity.dart';

abstract class PopularPersonDetailsLocalDataSource {
  storePopularPersonDetails(PopularPersonDetailsEntity popularPersonDetailsEntity);

  PopularPersonDetailsEntity? getLocalPopularPersonDetails(int personId);
}
