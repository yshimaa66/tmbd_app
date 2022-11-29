import 'package:equatable/equatable.dart';
import 'package:tmdb_app/features/popular_person_details/data/models/movie_credits.dart'
    as movie_credits;
import 'package:tmdb_app/features/popular_person_details/data/models/other_images.dart';
import 'package:tmdb_app/features/popular_person_details/data/models/tv_credits.dart'
    as tv_credits;
import 'package:tmdb_app/features/popular_person_details/domain/entities/cast_entity.dart';
import 'package:tmdb_app/features/popular_person_details/domain/entities/popular_person_details_entity.dart';

class PopularPersonDetails extends Equatable {
  bool? adult;
  List<String>? alsoKnownAs;
  String? biography;
  String? birthday;
  int? gender;
  int? id;
  String? imdbId;
  String? knownForDepartment;
  String? name;
  String? placeOfBirth;
  double? popularity;
  String? profilePath;
  OtherImages? otherImages;
  List<movie_credits.Cast>? movieCreditsCast;
  List<tv_credits.Cast>? tvCreditsCast;

  PopularPersonDetails(
      {this.adult,
      this.alsoKnownAs,
      this.biography,
      this.birthday,
      this.gender,
      this.id,
      this.imdbId,
      this.knownForDepartment,
      this.name,
      this.placeOfBirth,
      this.popularity,
      this.profilePath,
      this.otherImages,
      this.movieCreditsCast,
      this.tvCreditsCast});

  PopularPersonDetails.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    alsoKnownAs = json['also_known_as'].cast<String>();
    biography = json['biography'];
    birthday = json['birthday'];
    gender = json['gender'];
    id = json['id'];
    imdbId = json['imdb_id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    placeOfBirth = json['place_of_birth'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = this.adult;
    data['also_known_as'] = this.alsoKnownAs;
    data['biography'] = this.biography;
    data['birthday'] = this.birthday;
    data['gender'] = this.gender;
    data['id'] = this.id;
    data['imdb_id'] = this.imdbId;
    data['known_for_department'] = this.knownForDepartment;
    data['name'] = this.name;
    data['place_of_birth'] = this.placeOfBirth;
    data['popularity'] = this.popularity;
    data['profile_path'] = this.profilePath;
    return data;
  }

  PopularPersonDetails copyWith({
    bool? adult,
    List<String>? alsoKnownAs,
    String? biography,
    String? birthday,
    int? gender,
    int? id,
    String? imdbId,
    String? knownForDepartment,
    String? name,
    String? placeOfBirth,
    double? popularity,
    String? profilePath,
    OtherImages? otherImages,
    List<movie_credits.Cast>? movieCreditsCast,
    List<tv_credits.Cast>? tvCreditsCast,
  }) =>
      PopularPersonDetails(
          adult: adult ?? this.adult,
          alsoKnownAs: alsoKnownAs ?? this.alsoKnownAs,
          biography: biography ?? this.biography,
          birthday: birthday ?? this.birthday,
          gender: gender ?? this.gender,
          id: id ?? this.id,
          imdbId: imdbId ?? this.imdbId,
          knownForDepartment: knownForDepartment ?? this.knownForDepartment,
          name: name ?? this.name,
          placeOfBirth: placeOfBirth ?? this.placeOfBirth,
          popularity: popularity ?? this.popularity,
          profilePath: profilePath ?? this.profilePath,
          otherImages: otherImages ?? this.otherImages,
          movieCreditsCast: movieCreditsCast ?? this.movieCreditsCast,
          tvCreditsCast: tvCreditsCast ?? this.tvCreditsCast);

  PopularPersonDetailsEntity toDomain() {
    return PopularPersonDetailsEntity(
        id: id,
        name: name,
        birthday: birthday,
        placeOfBirth: placeOfBirth,
        alsoKnownAs: alsoKnownAs,
        knownForDepartment: knownForDepartment,
        profilePath: profilePath,
        biography: biography,
        images: otherImages!.profiles!.map((e) => e.filePath ?? "").toList(),
        movieCreditCasts: movieCreditsCast!
            .map((e) => CastEntity(
                name: "",
                title: e.title,
                posterPath: e.posterPath,
                backdropPath: e.backdropPath,
                voteAverage: e.voteAverage,
                voteCount: e.voteCount))
            .toList(),
        tvCreditCasts: tvCreditsCast!
            .map((e) => CastEntity(
                name: e.name,
                title: "",
                posterPath: e.posterPath,
                backdropPath: e.backdropPath,
                voteAverage: e.voteAverage,
                voteCount: e.voteCount))
            .toList(),
        popularity: popularity);
  }

  @override
  List get props => [
        adult,
        alsoKnownAs,
        biography,
        birthday,
        gender,
        id,
        imdbId,
        knownForDepartment,
        name,
        placeOfBirth,
        popularity,
        profilePath
      ];
}
