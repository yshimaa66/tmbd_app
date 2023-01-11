import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:tmdb_app/core/error/exceptions.dart';
import 'package:tmdb_app/features/popular_person_details/data/data_source/local/popular_person_details_LDS.dart';
import 'package:tmdb_app/features/popular_person_details/domain/entities/popular_person_details_entity.dart';

@LazySingleton(as: PopularPersonDetailsLocalDataSource)
class PopularPersonDetailsLocalDataSourceImpl
    implements PopularPersonDetailsLocalDataSource {
  @override
  storePopularPersonDetails(
      PopularPersonDetailsEntity popularPersonDetailsEntity) {
    GetStorage().write("person_${popularPersonDetailsEntity.id}",
        popularPersonDetailsEntity.toJson());
  }

  @override
  PopularPersonDetailsEntity? getLocalPopularPersonDetails(int personId) {
    if (GetStorage().hasData("person_$personId")) {
      throw LocalDatabaseException("No Local data found");
    }
    PopularPersonDetailsEntity popularPersonDetailsEntity =
        PopularPersonDetailsEntity.fromJson(
            GetStorage().read("person_$personId"));
    return popularPersonDetailsEntity;
  }
}
