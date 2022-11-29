import 'package:equatable/equatable.dart';
import 'package:tmdb_app/features/popular_persons/domain/entities/popular_person_entity.dart';

class AllPopularPersonsEntity extends Equatable {
  int? page, totalPages, totalResults;
  List<PopularPersonEntity>? results;

  AllPopularPersonsEntity(
      {this.page = -1,
      this.totalPages = -1,
      this.totalResults = -1,
      this.results = const []});

  AllPopularPersonsEntity.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <PopularPersonEntity>[];
      json['results'].forEach((v) {
        results!.add(new PopularPersonEntity.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['results'] = this.results!.map((v) => v.toJson()).toList();
    data['total_pages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    return data;
  }

  @override
  List<Object> get props => [page!, totalPages!, totalResults!, results!];
}
