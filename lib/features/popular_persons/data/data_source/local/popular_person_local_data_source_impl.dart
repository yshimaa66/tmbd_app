import 'package:get_storage/get_storage.dart';
import 'package:tmdb_app/features/popular_persons/data/data_source/local/popular_person_local_data_source.dart';
import 'package:tmdb_app/models/all_popular_persons/all_popular_persons.dart';

final _box = GetStorage();

class PopularPersonLocalDataSourceImpl implements PopularPersonLocalDataSource{
  @override
  AllPopularPersons? getAllPopularPersons(int page) {
    if (!_box.hasData("popular_$page")) return null;
    AllPopularPersons p =
        AllPopularPersons.fromJson(_box.read("popular_$page"));
    return p;
  }

  @override
  storeAllPopularPersons(AllPopularPersons allPopularPersons) {
    _box.write("popular_${allPopularPersons.page}", allPopularPersons.toJson());
  }
}
