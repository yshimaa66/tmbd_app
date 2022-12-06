import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tmdb_app/features/popular_persons/domain/entities/popular_person_entity.dart';

class PopularPerson extends Equatable {
  bool? adult;
  int? gender;
  int? id;
  List<KnownFor>? knownFor;
  String? knownForDepartment;
  String? name;
  double? popularity;
  String? profilePath;

  PopularPerson(
      {this.adult,
      this.gender,
      this.id,
      this.knownFor,
      this.knownForDepartment,
      this.name,
      this.popularity,
      this.profilePath});

  PopularPerson.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    if (json['known_for'] != null) {
      knownFor = <KnownFor>[];
      json['known_for'].forEach((v) {
        knownFor!.add(new KnownFor.fromJson(v));
      });
    }
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = this.adult;
    data['gender'] = this.gender;
    data['id'] = this.id;
    if (this.knownFor != null) {
      data['known_for'] = this.knownFor!.map((v) => v.toJson()).toList();
    }
    data['known_for_department'] = this.knownForDepartment;
    data['name'] = this.name;
    data['popularity'] = this.popularity;
    data['profile_path'] = this.profilePath;
    return data;
  }

  PopularPerson copyWith({
    bool? adult,
    int? gender,
    int? id,
    List<KnownFor>? knownFor,
    String? knownForDepartment,
    String? name,
    double? popularity,
    String? profilePath,
  }) =>
      PopularPerson(
          adult: adult ?? this.adult,
          gender: gender ?? this.gender,
          id: id ?? this.id,
          knownFor: knownFor ?? this.knownFor,
          knownForDepartment: knownForDepartment ?? this.knownForDepartment,
          name: name ?? this.name,
          popularity: popularity ?? this.popularity,
          profilePath: profilePath ?? this.profilePath);

  @override
  List get props => [
        adult,
        gender,
        id,
        knownFor,
        knownForDepartment,
        name,
        popularity,
        profilePath
      ];

  PopularPersonEntity toDomain() {
    return PopularPersonEntity(
        id: id??-1,
        name: name??"",
        knownForDepartment: knownForDepartment??"",
        profilePath: profilePath??"");
  }
}

class KnownFor extends Equatable {
  String? backdropPath;
  String? firstAirDate;
  List<int>? genreIds;
  int? id;
  String? mediaType;
  String? name;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  String? posterPath;
  double? voteAverage;
  int? voteCount;
  bool? adult;
  String? originalTitle;
  String? releaseDate;
  String? title;
  bool? video;

  KnownFor(
      {this.backdropPath,
      this.firstAirDate,
      this.genreIds,
      this.id,
      this.mediaType,
      this.name,
      this.originCountry,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.posterPath,
      this.voteAverage,
      this.voteCount,
      this.adult,
      this.originalTitle,
      this.releaseDate,
      this.title,
      this.video});

  KnownFor.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];
    firstAirDate = json['first_air_date'];
    genreIds = json['genre_ids'] == null ? [] : json['genre_ids'].cast<int>();
    id = json['id'];
    mediaType = json['media_type'];
    name = json['name'];
    originCountry = json['origin_country'] == null
        ? []
        : json['origin_country'].cast<String>();
    // : List<String>.from(json["origin_country"].map((x) => x));
    originalLanguage = json['original_language'];
    originalName = json['original_name'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    voteAverage = json['vote_average'] == null
        ? 0
        : double.parse(json['vote_average'].toString());
    voteCount = json['vote_count'];
    adult = json['adult'];
    originalTitle = json['original_title'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['backdrop_path'] = this.backdropPath;
    data['first_air_date'] = this.firstAirDate;
    data['genre_ids'] = this.genreIds;
    data['id'] = this.id;
    data['media_type'] = this.mediaType;
    data['name'] = this.name;
    data['origin_country'] = this.originCountry;
    data['original_language'] = this.originalLanguage;
    data['original_name'] = this.originalName;
    data['overview'] = this.overview;
    data['poster_path'] = this.posterPath;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    data['adult'] = this.adult;
    data['original_title'] = this.originalTitle;
    data['release_date'] = this.releaseDate;
    data['title'] = this.title;
    data['video'] = this.video;
    return data;
  }

  @override
  List get props => [
        backdropPath,
        firstAirDate,
        genreIds,
        id,
        mediaType,
        name,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        posterPath,
        voteAverage,
        voteCount,
        adult,
        originalTitle,
        releaseDate,
        title,
        video
      ];
}
