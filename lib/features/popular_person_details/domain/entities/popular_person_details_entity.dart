import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:tmdb_app/features/popular_person_details/data/models/popular_person_details.dart';
import 'package:tmdb_app/features/popular_person_details/domain/entities/cast_entity.dart';

class PopularPersonDetailsEntity extends Equatable {
  int? id;
  String? name, birthday, placeOfBirth, knownForDepartment, profilePath;
  List<String>? alsoKnownAs;
  String? biography;
  List<CastEntity>? movieCreditCasts;
  List<CastEntity>? tvCreditCasts;
  List<String>? images;
  double? popularity;

  PopularPersonDetailsEntity(
      {this.id = -1,
      this.name = "",
      this.birthday = "",
      this.placeOfBirth = "",
      this.knownForDepartment = "",
      this.profilePath = "",
      this.alsoKnownAs = const [],
      this.biography = "",
      this.movieCreditCasts = const [],
      this.tvCreditCasts = const [],
      this.images = const [],
      this.popularity = 0});

  PopularPersonDetailsEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    birthday = json['birthday'];
    placeOfBirth = json["placeOfBirth"];
    knownForDepartment = json["knownForDepartment"];
    profilePath = json["profilePath"];
    alsoKnownAs =
        json["alsoKnownAs"] == null ? [] : json["alsoKnownAs"].cast<String>();
    biography = json["biography"];
    if (json['movieCreditCasts'] != null) {
      movieCreditCasts = <CastEntity>[];
      json['movieCreditCasts'].forEach((v) {
        movieCreditCasts!.add(new CastEntity.fromJson(v));
      });
    }
    if (json['tvCreditCasts'] != null) {
      tvCreditCasts = <CastEntity>[];
      json['tvCreditCasts'].forEach((v) {
        tvCreditCasts!.add(new CastEntity.fromJson(v));
      });
    }
    images = json['images'] == null ? [] : json['images'].cast<String>();
    popularity = json["popularity"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['birthday'] = this.birthday;
    data['placeOfBirth'] = this.placeOfBirth;
    data['knownForDepartment'] = this.knownForDepartment;
    data['profilePath'] = this.profilePath;
    data['alsoKnownAs'] = this.alsoKnownAs;
    data['biography'] = this.biography;
    data['movieCreditCasts'] =
        this.movieCreditCasts!.map((v) => v.toJson()).toList();
    ;
    data['tvCreditCasts'] = this.tvCreditCasts!.map((v) => v.toJson()).toList();
    data['images'] = this.images;
    data['popularity'] = this.popularity;
    return data;
  }

  PopularPersonDetailsEntity copyWith({
    int? id,
    String? name,
    birthday,
    placeOfBirth,
    knownForDepartment,
    profilePath,
    List<String>? alsoKnownAs,
    String? biography,
    List<CastEntity>? movieCreditCasts,
    List<CastEntity>? tvCreditCasts,
    List<String>? images,
    double? popularity,
  }) =>
      PopularPersonDetailsEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        birthday: birthday ?? this.birthday,
        placeOfBirth: placeOfBirth ?? this.placeOfBirth,
        knownForDepartment: knownForDepartment ?? this.knownForDepartment,
        profilePath: profilePath ?? this.profilePath,
        alsoKnownAs: alsoKnownAs ?? this.alsoKnownAs,
        biography: biography ?? this.biography,
        movieCreditCasts: movieCreditCasts ?? this.movieCreditCasts,
        tvCreditCasts: tvCreditCasts ?? this.tvCreditCasts,
        images: images ?? this.images,
        popularity: popularity ?? this.popularity,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        birthday,
        placeOfBirth,
        knownForDepartment,
        profilePath,
        alsoKnownAs,
        biography,
        movieCreditCasts,
        tvCreditCasts,
        images,
        popularity
      ];
}
