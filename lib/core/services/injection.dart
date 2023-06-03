import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:tmdb_app/core/services/injection.config.dart';


final GetIt getIt = GetIt.instance;

@injectableInit
void configureInjection() {
  getIt.init(environment: Environment.dev);
}