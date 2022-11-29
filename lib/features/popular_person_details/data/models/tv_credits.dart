import 'package:equatable/equatable.dart';

class TVCredits extends Equatable {
  List<Cast>? cast;
  List<Crew>? crew;
  int? id;

  TVCredits({this.cast, this.crew, this.id});

  TVCredits.fromJson(Map<String, dynamic> json) {
    if (json['cast'] != null) {
      cast = <Cast>[];
      json['cast'].forEach((v) {
        cast!.add(new Cast.fromJson(v));
      });
    }
    if (json['crew'] != null) {
      crew = <Crew>[];
      json['crew'].forEach((v) {
        crew!.add(new Crew.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cast != null) {
      data['cast'] = this.cast!.map((v) => v.toJson()).toList();
    }
    if (this.crew != null) {
      data['crew'] = this.crew!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }

  @override
  List get props => [cast, crew, id];
}

class Cast extends Equatable {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  String? firstAirDate;
  String? name;
  double? voteAverage;
  int? voteCount;
  String? character;
  String? creditId;
  int? episodeCount;

  Cast(
      {this.adult,
      this.backdropPath,
      this.genreIds,
      this.id,
      this.originCountry,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.popularity,
      this.posterPath,
      this.firstAirDate,
      this.name,
      this.voteAverage,
      this.voteCount,
      this.character,
      this.creditId,
      this.episodeCount});

  Cast.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originCountry = json['origin_country'].cast<String>();
    originalLanguage = json['original_language'];
    originalName = json['original_name'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    firstAirDate = json['first_air_date'];
    name = json['name'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    character = json['character'];
    creditId = json['credit_id'];
    episodeCount = json['episode_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['genre_ids'] = this.genreIds;
    data['id'] = this.id;
    data['origin_country'] = this.originCountry;
    data['original_language'] = this.originalLanguage;
    data['original_name'] = this.originalName;
    data['overview'] = this.overview;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    data['first_air_date'] = this.firstAirDate;
    data['name'] = this.name;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    data['character'] = this.character;
    data['credit_id'] = this.creditId;
    data['episode_count'] = this.episodeCount;
    return data;
  }

  @override
  List get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        firstAirDate,
        name,
        voteAverage,
        voteCount,
        character,
        creditId,
        episodeCount
      ];
}

class Crew extends Equatable {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  String? firstAirDate;
  String? name;
  double? voteAverage;
  int? voteCount;
  String? creditId;
  String? department;
  int? episodeCount;
  String? job;

  Crew(
      {this.adult,
      this.backdropPath,
      this.genreIds,
      this.id,
      this.originCountry,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.popularity,
      this.posterPath,
      this.firstAirDate,
      this.name,
      this.voteAverage,
      this.voteCount,
      this.creditId,
      this.department,
      this.episodeCount,
      this.job});

  Crew.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originCountry = json['origin_country'].cast<String>();
    originalLanguage = json['original_language'];
    originalName = json['original_name'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    firstAirDate = json['first_air_date'];
    name = json['name'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    creditId = json['credit_id'];
    department = json['department'];
    episodeCount = json['episode_count'];
    job = json['job'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['genre_ids'] = this.genreIds;
    data['id'] = this.id;
    data['origin_country'] = this.originCountry;
    data['original_language'] = this.originalLanguage;
    data['original_name'] = this.originalName;
    data['overview'] = this.overview;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    data['first_air_date'] = this.firstAirDate;
    data['name'] = this.name;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    data['credit_id'] = this.creditId;
    data['department'] = this.department;
    data['episode_count'] = this.episodeCount;
    data['job'] = this.job;
    return data;
  }

  @override
  List get props => [
    adult,
    backdropPath,
    genreIds,
    id,
    originCountry,
    originalLanguage,
    originalName,
    overview,
    popularity,
    posterPath,
    firstAirDate,
    name,
    voteAverage,
    voteCount,
    creditId,
    department,
    episodeCount,
    job
  ];
}
