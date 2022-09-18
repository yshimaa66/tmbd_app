// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_popular_persons.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AllPopularPersons _$$_AllPopularPersonsFromJson(Map<String, dynamic> json) =>
    _$_AllPopularPersons(
      page: json['page'] as int?,
      totalPages: json['total_pages'] as int?,
      totalResults: json['total_results'] as int?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => PopularPerson.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_AllPopularPersonsToJson(
        _$_AllPopularPersons instance) =>
    <String, dynamic>{
      'page': instance.page,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
      'results': instance.results,
    };
