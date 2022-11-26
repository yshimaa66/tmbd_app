import 'package:tmdb_app/core/services/api_service.dart';
import 'package:tmdb_app/data/local/person_db.dart';
import 'package:tmdb_app/features/popular_persons/data/models/popular_person/popular_person.dart';
import 'package:tmdb_app/main.dart';
import 'package:tmdb_app/models/all_popular_persons/all_popular_persons.dart';

class PopularPersonRepository {
  final PersonDb _db;
  final APIService _apiService;

  PopularPersonRepository(this._db, this._apiService);

  Future<void> storeAllPopularPersons(AllPopularPersons allPopularPersons) async {
    await _db.storeAllPopularPersons(allPopularPersons);
  }

  Future<PopularPerson?> getPopularPersonDetail({required int personId}) async {
    // if (mainCubit.internetAvailable){
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
    // } else {
    //   return _db.getPersonDetail(personId);
    // }
  }
}
