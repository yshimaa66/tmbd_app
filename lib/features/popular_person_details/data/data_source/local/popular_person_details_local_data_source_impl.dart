import 'package:get_storage/get_storage.dart';
import 'package:tmdb_app/core/services/services_locator.dart';
import 'package:tmdb_app/features/popular_person_details/data/data_source/local/popular_person_details_local_data_source.dart';
import 'package:tmdb_app/features/popular_person_details/data/models/popular_person_details.dart';
import 'package:tmdb_app/features/popular_person_details/domain/entities/popular_person_details_entity.dart';

class PopularPersonDetailsLocalDataSourceImpl
    implements PopularPersonDetailsLocalDataSource {
  @override
  storePopularPersonDetails(
      PopularPersonDetailsEntity popularPersonDetailsEntity) {
    sl<GetStorage>().write(
        "person_${popularPersonDetailsEntity.id}", popularPersonDetailsEntity.toJson());
  }

  @override
  PopularPersonDetailsEntity? getLocalPopularPersonDetails(int personId) {
    if (!sl<GetStorage>().hasData("person_$personId")) return null;

    PopularPersonDetailsEntity popularPersonDetailsEntity = PopularPersonDetailsEntity.fromJson(
        sl<GetStorage>().read("person_$personId"));
    return popularPersonDetailsEntity;
  }
}
