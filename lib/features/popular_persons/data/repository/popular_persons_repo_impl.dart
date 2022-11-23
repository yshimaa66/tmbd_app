import 'package:tmdb_app/features/popular_persons/data/data_source/remote/popular_person_remote_data_source.dart';
import 'package:tmdb_app/features/popular_persons/domain/repository/popular_persons_repo.dart';

class PopularPersonsRepoImpl implements PopularPersonsRepo {
  final PopularPersonRemoteDataSource popularPersonRemoteDataSource;

  PopularPersonsRepoImpl(this.popularPersonRemoteDataSource);

  @override
  getPopularPersons(int currentPage) async {
    final result =
        await popularPersonRemoteDataSource.getPopularPerson(page: currentPage);
  }
}
