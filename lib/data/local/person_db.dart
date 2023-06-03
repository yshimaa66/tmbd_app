import 'package:get_storage/get_storage.dart';
import 'package:tmdb_app/features/popular_person_details/data/models/popular_person_details.dart';
import 'package:tmdb_app/features/popular_persons/data/models/all_popular_persons/all_popular_persons.dart';
import 'package:tmdb_app/features/popular_persons/data/models/popular_person/popular_person.dart';

final _box = GetStorage();

class PersonDb {
  storeAllPopularPersons(AllPopularPersons allPopularPersons) {
    _box.write("popular_${allPopularPersons.page}", allPopularPersons.toJson());
  }

  setPersonDetails(PopularPersonDetails popularPersonDetails) {
    _box.write("person_${popularPersonDetails.id}", popularPersonDetails.toJson());
  }

  PopularPersonDetails? getPersonDetail(int personId) {
    if (!_box.hasData("person_$personId")) return null;

    PopularPersonDetails popularPersonDetails = PopularPersonDetails.fromJson(_box.read("person_$personId"));
    return popularPersonDetails;
  }
}
