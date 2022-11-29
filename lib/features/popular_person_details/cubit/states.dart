import 'package:tmdb_app/features/popular_person_details/data/models/popular_person_details.dart';
import 'package:tmdb_app/features/popular_persons/data/models/popular_person/popular_person.dart';

abstract class PopularPersonDetailsStates {}

class Initial extends PopularPersonDetailsStates {}

class LoadingDetails extends PopularPersonDetailsStates {}

class PopularPersonDetailsError extends PopularPersonDetailsStates {
  final String error;
  PopularPersonDetailsError(this.error);
}

class PopularPersonDetailsSuccess extends PopularPersonDetailsStates{
  PopularPersonDetails? popularPersonDetails;
  PopularPersonDetailsSuccess(this.popularPersonDetails);
}

