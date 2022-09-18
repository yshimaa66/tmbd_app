abstract class PopularPersonsStates {}

class Initial extends PopularPersonsStates {}

class LoadingMore extends PopularPersonsStates {}

class PopularPersonsEmpty extends PopularPersonsStates{}

class PopularPersonsError extends PopularPersonsStates {
  final String error;
  PopularPersonsError(this.error);
}

class PopularPersonsSuccess extends PopularPersonsStates{}

