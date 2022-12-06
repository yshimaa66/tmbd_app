import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tmdb_app/core/error/exceptions.dart';
import 'package:tmdb_app/core/services/services_locator.dart';
import 'package:tmdb_app/features/popular_persons/data/data_source/local/popular_persons_local_data_source.dart';
import 'package:tmdb_app/features/popular_persons/data/models/all_popular_persons/all_popular_persons.dart';
import 'package:tmdb_app/features/popular_persons/domain/entities/all_popular_persons_entity.dart';

class PopularPersonsLocalDataSourceImpl
    implements PopularPersonsLocalDataSource {
  @override
  AllPopularPersonsEntity? getAllLocalPopularPersons(int page) {
    if (!sl<GetStorage>().hasData("popular_$page")){
      throw LocalDatabaseException("No Local data found");
    };
    AllPopularPersonsEntity allPopularPersonsEntity =
        AllPopularPersonsEntity.fromJson(sl<GetStorage>().read("popular_$page"));
    return allPopularPersonsEntity;
  }

  @override
  Future storeAllPopularPersons(AllPopularPersonsEntity allPopularPersonsEntity) async {
    debugPrint("LocalDataSourceImpl storeAllPopularPersons");
    await sl<GetStorage>()
        .write("popular_${allPopularPersonsEntity.page}", allPopularPersonsEntity.toJson());
  }
}
