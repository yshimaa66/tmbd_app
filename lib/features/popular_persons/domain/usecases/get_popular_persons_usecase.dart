import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb_app/core/error/failure.dart';
import 'package:tmdb_app/core/usecase/base_usecase.dart';
import 'package:tmdb_app/features/popular_persons/domain/repository/popular_persons_repo.dart';
import 'package:tmdb_app/models/all_popular_persons/all_popular_persons.dart';

class GetPopularPersonsUseCase implements BaseUseCase<AllPopularPersons?,PopularPersonsParameters>{
  final PopularPersonsRepo popularPersonsRepo;

  GetPopularPersonsUseCase(this.popularPersonsRepo);

  @override
  Future<Either<Failure, AllPopularPersons?>> call(parameters) {
    return popularPersonsRepo.getPopularPersons(parameters);
  }


}

class PopularPersonsParameters extends Equatable{
  final int currentPage;

  PopularPersonsParameters(this.currentPage);

  @override
  List<Object?> get props => [currentPage];
}