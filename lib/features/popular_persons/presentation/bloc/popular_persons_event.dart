part of 'popular_persons_bloc.dart';

@immutable
abstract class PopularPersonsEvent extends Equatable {
  const PopularPersonsEvent();
}

class GetPopularPersons extends PopularPersonsEvent {
  const GetPopularPersons();

  @override
  List<Object?> get props => [];
}

class GetLocalPopularPersons extends PopularPersonsEvent {
  const GetLocalPopularPersons();

  @override
  List<Object?> get props => [];
}

class LoadMore extends PopularPersonsEvent {
  const LoadMore();

  @override
  List<Object?> get props => [];
}

class RefreshPopularPersons extends PopularPersonsEvent {
  const RefreshPopularPersons();

  @override
  List<Object?> get props => [];
}

class OnEndScroll extends PopularPersonsEvent {
  const OnEndScroll();

  @override
  List<Object?> get props => [];
}
