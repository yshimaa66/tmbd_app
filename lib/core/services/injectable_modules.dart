import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class InjectableModule {
  @singleton
  Dio get dio => Dio();
}