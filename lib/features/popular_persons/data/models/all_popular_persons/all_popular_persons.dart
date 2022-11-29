import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tmdb_app/features/popular_persons/data/models/popular_person/popular_person.dart';

class AllPopularPersons {
  int? page;
  List<PopularPerson>? results;
  int? totalPages;
  int? totalResults;

  AllPopularPersons({this.page, this.results, this.totalPages, this.totalResults});

  AllPopularPersons.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <PopularPerson>[];
      json['results'].forEach((v) {
        results!.add(new PopularPerson.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    return data;
  }
}
