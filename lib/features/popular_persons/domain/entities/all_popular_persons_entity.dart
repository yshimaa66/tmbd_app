import 'package:equatable/equatable.dart';
import 'package:tmdb_app/features/popular_persons/domain/entities/popular_person_entity.dart';

class AllPopularPersonsEntity extends Equatable {
  final int page, totalPages, totalResults;
  final List<PopularPersonEntity> results;

  const AllPopularPersonsEntity(
      {this.page = -1,
      this.totalPages = -1,
      this.totalResults = -1,
      this.results = const []});

  @override
  List<Object> get props => [page, totalPages, totalResults, results];
}
