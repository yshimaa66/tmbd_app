import 'package:get_storage/get_storage.dart';
import 'package:tmdb_app/features/popular_persons/data/models/popular_person/popular_person.dart';
import 'package:tmdb_app/models/all_popular_persons/all_popular_persons.dart';

final _box = GetStorage();

class PersonDb {
  storeAllPopularPersons(AllPopularPersons allPopularPersons) {
    _box.write("popular_${allPopularPersons.page}", allPopularPersons.toJson());
  }

  setPersonDetails(PopularPerson popularPerson) {
    _box.write("person_${popularPerson.id}", popularPerson.toJson());
  }

  PopularPerson? getPersonDetail(int personId) {
    if (!_box.hasData("person_$personId")) return null;

    PopularPerson p = PopularPerson.fromJson(_box.read("person_$personId"));
    return p;
  }
}
