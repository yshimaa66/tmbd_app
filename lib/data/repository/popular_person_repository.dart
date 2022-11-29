import 'package:tmdb_app/core/services/api_service.dart';
import 'package:tmdb_app/data/local/person_db.dart';
import 'package:tmdb_app/features/popular_person_details/data/models/movie_credits.dart' as movie_credits;
import 'package:tmdb_app/features/popular_person_details/data/models/popular_person_details.dart';
import 'package:tmdb_app/features/popular_person_details/data/models/tv_credits.dart' as tv_credits;
import 'package:tmdb_app/features/popular_person_details/data/models/other_images.dart';
import 'package:tmdb_app/features/popular_persons/data/models/all_popular_persons/all_popular_persons.dart';
import 'package:tmdb_app/features/popular_persons/data/models/popular_person/popular_person.dart';

class PopularPersonRepository {
  final PersonDb _db;

  PopularPersonRepository(this._db);

  Future<void> storeAllPopularPersons(AllPopularPersons allPopularPersons) async {
    await _db.storeAllPopularPersons(allPopularPersons);
  }

  Future<PopularPersonDetails?> getPopularPersonDetail({required int personId}) async {
    // if (mainCubit.internetAvailable){
    //   try {
    //     final personDetails = await _apiService.get('/person/$personId');
    //     PopularPersonDetails popularPersonDetails = PopularPersonDetails.fromJson(personDetails);
    //
    //     final otherImages = await _apiService.get('/person/$personId/images');
    //     OtherImages images = OtherImages.fromJson(otherImages);
    //
    //     final movieCreditsResponse =
    //         await _apiService.get('/person/$personId/movie_credits');
    //     List<dynamic> movieCreditsListMap = movieCreditsResponse['cast'];
    //     List<movie_credits.Cast> movieCredits =
    //         movieCreditsListMap.map((e) => movie_credits.Cast.fromJson(e)).toList();
    //
    //     final tvCreditsResponse =
    //         await _apiService.get('/person/$personId/tv_credits');
    //     List<dynamic> tvCreditsListMap = tvCreditsResponse['cast'];
    //     List<tv_credits.Cast> tvCredits =
    //         tvCreditsListMap.map((e) => tv_credits.Cast.fromJson(e)).toList();
    //
    //     popularPersonDetails = popularPersonDetails.copyWith(
    //       otherImages: images,
    //       tvCreditsCast: tvCredits,
    //       movieCreditsCast: movieCredits,
    //     );
    //
    //     // store details into cache
    //     _db.setPersonDetails(popularPersonDetails);
    //
    //     return popularPersonDetails;
    //   } catch (e) {
    //     return _db.getPersonDetail(personId);
    //   }
    // } else {
    //   return _db.getPersonDetail(personId);
    // }
  }
}
