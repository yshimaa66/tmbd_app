import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tmdb_app/features/popular_persons/data/models/popular_person/popular_person.dart';

part 'all_popular_persons.freezed.dart';
part 'all_popular_persons.g.dart';

@freezed
class AllPopularPersons with _$AllPopularPersons {
  const AllPopularPersons._();
  factory AllPopularPersons({
    int? page,
    @JsonKey(name: 'total_pages') int? totalPages,
    @JsonKey(name: 'total_results') int? totalResults,
    List<PopularPerson>? results,
  }) = _AllPopularPersons;

  factory AllPopularPersons.fromJson(Map<String, dynamic> json) =>
      _$AllPopularPersonsFromJson(json);
}
