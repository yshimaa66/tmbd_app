part of 'popular_persons_bloc.dart';

class PopularPersonsState extends Equatable {
  final List<PopularPerson> popularPersons;
  final RequestState requestState;
  final String errorMessage;
  final int currentPage;
  final bool getFirstData;
  final bool lastPage;
  final bool loadingMore;

  PopularPersonsState(
      {this.popularPersons = const [],
      this.requestState = RequestState.loading,
      this.errorMessage = "",
      this.currentPage = 1,
      this.getFirstData = false,
      this.lastPage = false,
      this.loadingMore = false});

  PopularPersonsState copyWith({
    List<PopularPerson>? popularPersons,
    RequestState? requestState,
    String? errorMessage,
    int? currentPage,
    bool? getFirstData,
    bool? lastPage,
    bool? loadingMore,
  }) {
    return PopularPersonsState(
        popularPersons: popularPersons ?? this.popularPersons,
        requestState: requestState ?? this.requestState,
        errorMessage: errorMessage ?? this.errorMessage,
        currentPage: currentPage ?? this.currentPage,
        getFirstData: getFirstData ?? this.getFirstData,
        lastPage: lastPage ?? this.lastPage,
        loadingMore: loadingMore ?? this.loadingMore);
  }

  @override
  List<Object> get props => [
        popularPersons,
        requestState,
        errorMessage,
        currentPage,
        getFirstData,
        lastPage,
      ];
}
