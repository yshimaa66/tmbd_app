import 'package:tmdb_app/data/local/person_db.dart';
import 'package:tmdb_app/data/service/api_service.dart';
import 'package:tmdb_app/features/popular_persons/data/data_source/local/popular_person_local_data_source.dart';
import 'package:tmdb_app/features/popular_persons/data/data_source/remote/popular_person_remote_data_source.dart';
import 'package:tmdb_app/main.dart';
import 'package:tmdb_app/models/all_popular_persons/all_popular_persons.dart';

class PopularPersonRemoteDataSourceImpl implements PopularPersonRemoteDataSource{
  final PopularPersonLocalDataSource _localDataSource;
  final ApiService _apiService;

  PopularPersonRemoteDataSourceImpl(this._apiService, this._localDataSource);

  @override
  Future<AllPopularPersons?> getPopularPerson({int page = 1}) async {
    if (mainCubit.internetAvailable) {
      try {
        final response = await _apiService.get(
          '/person/popular',
          query: "page=$page",
        );
        final popular = AllPopularPersons.fromJson(response);

        // store page into cache
        await _localDataSource.storeAllPopularPersons(popular);
        return popular;
      } catch (e) {
        return _localDataSource.getAllPopularPersons(page);
      }
    } else {
      return _localDataSource.getAllPopularPersons(page);
    }
  }
}
