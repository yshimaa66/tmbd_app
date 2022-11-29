import 'package:tmdb_app/features/popular_person_details/data/models/popular_person_details.dart';
import 'package:tmdb_app/features/popular_persons/data/models/all_popular_persons/all_popular_persons.dart';

abstract class PopularPersonDetailsLocalDataSource {
  setPersonDetails(PopularPersonDetails popularPersonDetails);

  PopularPersonDetails? getPersonDetail(int personId);
}
