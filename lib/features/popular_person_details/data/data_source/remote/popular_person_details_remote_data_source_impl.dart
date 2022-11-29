import 'package:tmdb_app/core/API/api_consumer.dart';
import 'package:tmdb_app/core/API/end_points.dart';
import 'package:tmdb_app/features/popular_person_details/data/data_source/remote/popular_person_details_remote_data_source.dart';
import 'package:tmdb_app/features/popular_person_details/data/models/popular_person_details.dart';

class PopularPersonDetailsRemoteDataSourceImpl
    implements PopularPersonDetailsRemoteDataSource {
  final ApiConsumer apiConsumer;

  PopularPersonDetailsRemoteDataSourceImpl(this.apiConsumer);
     
  @override
  Future<PopularPersonDetails?> getPopularPersonDetails(int personId) async {
      Map<String, dynamic> result = Map<String, dynamic>.from(
        await apiConsumer.get(
          EndPoints.peopleInfoUrl(personId.toString()),
        ),
      );
      final popular = PopularPersonDetails.fromJson(result);
      return popular;
  }
}
