import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tmdb_app/core/services/services_locator.dart';
import 'package:tmdb_app/features/popular_persons/data/data_source/local/popular_persons_local_data_source.dart';
import 'package:tmdb_app/features/popular_persons/data/models/all_popular_persons/all_popular_persons.dart';

class PopularPersonsLocalDataSourceImpl
    implements PopularPersonsLocalDataSource {
  @override
  AllPopularPersons? getAllLocalPopularPersons(int page) {
    if (!sl<GetStorage>().hasData("popular_$page")) return null;
    AllPopularPersons allPopularPersons =
        AllPopularPersons.fromJson(sl<GetStorage>().read("popular_$page"));
    return allPopularPersons;
  }

  @override
  Future storeAllPopularPersons(AllPopularPersons allPopularPersons) async {
    debugPrint("LocalDataSourceImpl storeAllPopularPersons");
    await sl<GetStorage>()
        .write("popular_${allPopularPersons.page}", allPopularPersons.toJson());
  }
}
