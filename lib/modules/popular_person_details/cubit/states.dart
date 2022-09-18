import 'package:tmdb_app/models/popular_person/popular_person.dart';

abstract class PopularPersonDetailsStates {}

class Initial extends PopularPersonDetailsStates {}

class LoadingDetails extends PopularPersonDetailsStates {}

class PopularPersonDetailsError extends PopularPersonDetailsStates {
  final String error;
  PopularPersonDetailsError(this.error);
}

class PopularPersonDetailsSuccess extends PopularPersonDetailsStates{
  PopularPerson? person;
  PopularPersonDetailsSuccess(this.person);
}

