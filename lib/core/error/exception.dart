import 'package:tmdb_app/core/network/error_message_model.dart';

class ServerException implements Exception{
 final ErrorMessageModel errorMessageModel;

  ServerException(this.errorMessageModel);
}

class LocalDatabaseException implements Exception{
  final String message;

  LocalDatabaseException(this.message);
}