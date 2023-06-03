import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:tmdb_app/core/error/exceptions.dart';
import 'package:tmdb_app/features/popular_persons/data/data_source/local/popular_persons_LDS.dart';
import 'package:tmdb_app/features/popular_persons/domain/entities/all_popular_persons_entity.dart';

@LazySingleton(as: PopularPersonsLocalDataSource)
class PopularPersonsLocalDataSourceImpl
    implements PopularPersonsLocalDataSource {
  @override
  AllPopularPersonsEntity? getAllLocalPopularPersons(int page) {
    log("$page",name: "getAllLocalPopularPersons page");
    if (!GetStorage().hasData("popular_$page")) {
      throw LocalDatabaseException("No Local data found");
    }
    AllPopularPersonsEntity allPopularPersonsEntity =
        AllPopularPersonsEntity.fromJson(GetStorage().read("popular_$page"));
    return allPopularPersonsEntity;
  }

  @override
  Future storeAllPopularPersons(
      AllPopularPersonsEntity allPopularPersonsEntity) async {
    debugPrint("LocalDataSourceImpl storeAllPopularPersons");
    try {
      await GetStorage().write("popular_${allPopularPersonsEntity.page}",
          allPopularPersonsEntity.toJson()).whenComplete((){
            log("storeAllPopularPersons Complete");
      });
    }catch(e){
      throw LocalDatabaseException("Can't write in Local data");
    }
  }
}
