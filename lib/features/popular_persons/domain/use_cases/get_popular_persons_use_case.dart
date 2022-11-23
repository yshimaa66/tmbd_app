import 'package:tmdb_app/features/popular_persons/domain/repository/popular_persons_repo.dart';

class GetPopularPersonsUseCase {
  final PopularPersonsRepo popularPersonsRepo;

  GetPopularPersonsUseCase(this.popularPersonsRepo);

  call(int currentPage) {
    return popularPersonsRepo.getPopularPersons(currentPage);
  }
}
