part of 'popular_persons_bloc.dart';

@immutable
abstract class PopularPersonsEvent extends Equatable {
  const PopularPersonsEvent();
}

class GetPopularPersons extends PopularPersonsEvent {
  final int currentPage;

  GetPopularPersons(this.currentPage);

  @override
  List<Object?> get props => [currentPage];
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

class ToggleLoadingMore extends PopularPersonsEvent {
  const ToggleLoadingMore();

  @override
  List<Object?> get props => [];
}

class OnEndScroll extends PopularPersonsEvent {
  const OnEndScroll();

  @override
  List<Object?> get props => [];
}

class OnTopScroll extends PopularPersonsEvent {
  const OnTopScroll();

  @override
  List<Object?> get props => [];
}