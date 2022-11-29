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

class GetLocalPopularPersonDetails extends PopularPersonDetailsEvent {
  final int? personId;
  const GetLocalPopularPersonDetails({this.personId});

  @override
  List<Object?> get props => [personId];
}