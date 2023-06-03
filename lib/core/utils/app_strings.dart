class AppStrings {
  static const String appName = 'MovieDB';
  static const String popularPeopleScreenTitle = 'Popular People';
  static String personInfoScreenTitle(String personName) => '$personName Info';
  static const String apiErrorMessageKey = 'status_message';
  static const String fetchDataExceptionMessage = 'Error During Communication';
  static const String badRequestExceptionMessage = 'Bad Request';
  static const String unauthorizedExceptionMessage = 'Unauthorized';
  static const String notFoundExceptionMessage = 'Requested Info Not Found';
  static const String conflictExceptionMessage = 'Conflict Occurred';
  static const String internalExceptionMessage = 'Internal Server Error';
  static const String noInternetExceptionMessage = 'No Internet Connection';
}