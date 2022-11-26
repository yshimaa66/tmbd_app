import 'package:equatable/equatable.dart';
import 'package:tmdb_app/core/network/error_message_model.dart';

class ServerException extends Equatable implements Exception{
 final ErrorMessageModel errorMessageModel;

  ServerException(this.errorMessageModel);

  @override
  List<Object?> get props => [errorMessageModel];
}

class LocalDatabaseException extends Equatable implements Exception{
  final String errorMessage;

  LocalDatabaseException(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}