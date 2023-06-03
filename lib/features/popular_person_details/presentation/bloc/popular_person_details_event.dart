part of 'popular_person_details_bloc.dart';

@immutable
abstract class PopularPersonDetailsEvent extends Equatable {
  const PopularPersonDetailsEvent();
}

class GetPopularPersonDetails extends PopularPersonDetailsEvent {
  final int? personId;
  const GetPopularPersonDetails({this.personId});

  @override
  List<Object?> get props => [personId];
}

class GetPopularPersonImages extends PopularPersonDetailsEvent {
  const GetPopularPersonImages();

  @override
  List<Object?> get props => [];
}

class GetPopularPersonLocalImages extends PopularPersonDetailsEvent {
  const GetPopularPersonLocalImages();

  @override
  List<Object?> get props => [];
}

class GetPopularPersonMovies extends PopularPersonDetailsEvent {
  const GetPopularPersonMovies();

  @override
  List<Object?> get props => [];
}

class GetPopularPersonLocalMovies extends PopularPersonDetailsEvent {
  const GetPopularPersonLocalMovies();

  @override
  List<Object?> get props => [];
}

class GetPopularPersonTVShows extends PopularPersonDetailsEvent {
  const GetPopularPersonTVShows();

  @override
  List<Object?> get props => [];
}

class GetPopularPersonLocalTVShows extends PopularPersonDetailsEvent {
  const GetPopularPersonLocalTVShows();

  @override
  List<Object?> get props => [];
}

class GetLocalPopularPersonDetails extends PopularPersonDetailsEvent {
  final int? personId;
  const GetLocalPopularPersonDetails({this.personId});

  @override
  List<Object?> get props => [personId];
}