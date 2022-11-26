part of 'popular_persons_bloc.dart';

class PopularPersonsState extends Equatable {
  final List<PopularPerson> popularPersons;
  final RequestState requestState;
  final String errorMessage;
  final int currentPage;
  final bool getFirstData;
  final bool lastPage;
  final bool loadingMore;
  final bool isRefreshing;
  final DataSource dataSource;

  PopularPersonsState({
    this.popularPersons = const [],
    this.requestState = RequestState.loading,
    this.errorMessage = "",
    this.currentPage = 1,
    this.getFirstData = true,
    this.lastPage = false,
    this.loadingMore = false,
    this.isRefreshing = false,
    this.dataSource = DataSource.remote,
  });

  PopularPersonsState copyWith({
    List<PopularPerson>? popularPersons,
    RequestState? requestState,
    String? errorMessage,
    int? currentPage,
    bool? getFirstData,
    bool? lastPage,
    bool? loadingMore,
    bool? isRefreshing,
    DataSource? dataSource,
  }) {
    return PopularPersonsState(
        popularPersons: popularPersons ?? this.popularPersons,
        requestState: requestState ?? this.requestState,
        errorMessage: errorMessage ?? this.errorMessage,
        currentPage: currentPage ?? this.currentPage,
        getFirstData: getFirstData ?? this.getFirstData,
        lastPage: lastPage ?? this.lastPage,
        loadingMore: loadingMore ?? this.loadingMore,
        isRefreshing: isRefreshing ?? this.isRefreshing,
        dataSource: dataSource ?? this.dataSource);
  }

  @override
  List<Object> get props => [
        popularPersons,
        requestState,
        errorMessage,
        currentPage,
        getFirstData,
        lastPage,
        loadingMore,
        isRefreshing,
        dataSource
      ];
}
