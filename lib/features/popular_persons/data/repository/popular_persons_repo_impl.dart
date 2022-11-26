import 'package:dartz/dartz.dart';
import 'package:tmdb_app/core/error/exception.dart';
import 'package:tmdb_app/core/error/failure.dart';
import 'package:tmdb_app/features/popular_persons/data/data_source/remote/popular_person_remote_data_source.dart';
import 'package:tmdb_app/features/popular_persons/domain/repository/popular_persons_repo.dart';
import 'package:tmdb_app/features/popular_persons/domain/usecases/get_popular_persons_usecase.dart';
import 'package:tmdb_app/models/all_popular_persons/all_popular_persons.dart';

class PopularPersonsRepoImpl implements PopularPersonsRepo {
  final PopularPersonRemoteDataSource popularPersonRemoteDataSource;

  PopularPersonsRepoImpl(this.popularPersonRemoteDataSource);

  @override
  Future<Either<Failure,AllPopularPersons?>>getPopularPersons(PopularPersonsParameters popularPersonsParameters) async {
    final result =
        await popularPersonRemoteDataSource.getPopularPerson(page: popularPersonsParameters.currentPage);
    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(Failure(failure.errorMessageModel.statusMessage??""));
    }
  }
}
