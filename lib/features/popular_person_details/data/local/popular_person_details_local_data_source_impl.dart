import 'package:get_storage/get_storage.dart';
import 'package:tmdb_app/core/services/services_locator.dart';
import 'package:tmdb_app/features/popular_person_details/data/local/popular_person_details_local_data_source.dart';
import 'package:tmdb_app/features/popular_person_details/data/models/popular_person_details.dart';

class PopularPersonDetailsLocalDataSourceImpl
    implements PopularPersonDetailsLocalDataSource {
  @override
  setPersonDetails(PopularPersonDetails popularPersonDetails) {
    sl<GetStorage>().write(
        "person_${popularPersonDetails.id}", popularPersonDetails.toJson());
  }

  @override
  PopularPersonDetails? getPersonDetail(int personId) {
    if (!sl<GetStorage>().hasData("person_$personId")) return null;

    PopularPersonDetails popularPersonDetails = PopularPersonDetails.fromJson(
        sl<GetStorage>().read("person_$personId"));
    return popularPersonDetails;
  }
}
