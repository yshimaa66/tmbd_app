import 'package:tmdb_app/data/service/api_service.dart';
import 'package:tmdb_app/data/local/person_db.dart';
import 'package:tmdb_app/main.dart';
import 'package:tmdb_app/models/all_popular_persons/all_popular_persons.dart';
import 'package:tmdb_app/models/popular_person/popular_person.dart';

class PopularPersonRepository {
  final PersonDb _db;
  final ApiService _apiService;

  PopularPersonRepository(this._db, this._apiService);

  Future<void> storeAllPopularPersons(AllPopularPersons allPopularPersons) async {
    await _db.storeAllPopularPersons(allPopularPersons);
  }

  Future<AllPopularPersons?> getPopularPerson({int page = 1}) async {
    if (mainCubit.internetAvailable) {
      try {
        final response = await _apiService.get(
          '/person/popular',
          query: "page=$page",
        );
        final popular = AllPopularPersons.fromJson(response);

        // store page into cache
        await _db.storeAllPopularPersons(popular);
        return popular;
      } catch (e) {
        return _db.getPopular(page);
      }
    } else {
      return _db.getPopular(page);
    }
  }

  Future<PopularPerson?> getPopularPersonDetail({required int personId}) async {
    if (mainCubit.internetAvailable){
      try {
        final personDetails = await _apiService.get('/person/$personId');
        PopularPerson person = PopularPerson.fromJson(personDetails);

        final otherImages = await _apiService.get('/person/$personId/images');
        OtherImages images = OtherImages.fromJson(otherImages);

        final movieCreditsResponse =
            await _apiService.get('/person/$personId/movie_credits');
        List<dynamic> movieCreditsListMap = movieCreditsResponse['cast'];
        List<Casts> movieCredits =
            movieCreditsListMap.map((e) => Casts.fromJson(e)).toList();

        final tvCreditsResponse =
            await _apiService.get('/person/$personId/tv_credits');
        List<dynamic> tvCreditsListMap = tvCreditsResponse['cast'];
        List<Casts> tvCredits =
            tvCreditsListMap.map((e) => Casts.fromJson(e)).toList();

        person = person.copyWith(
          otherImages: images,
          tvCasts: tvCredits,
          movieCasts: movieCredits,
        );

        // store details into cache
        _db.setPersonDetails(person);

        return person;
      } catch (e) {
        return _db.getPersonDetail(personId);
      }
    } else {
      return _db.getPersonDetail(personId);
    }
  }
}
