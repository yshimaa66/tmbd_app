part of 'popular_person_details_bloc.dart';

@immutable
class PopularPersonDetailsState extends Equatable {
  final PopularPersonDetailsEntity? popularPersonDetailsEntity;
  final RequestState requestState,
      requestStateImages,
      requestStateMovies,
      requestStateTVShows;
  final String errorMessage;
  final DataSource dataSource;

  PopularPersonDetailsState(
      {this.popularPersonDetailsEntity,
      this.requestState = RequestState.loading,
      this.requestStateImages = RequestState.loading,
      this.requestStateMovies = RequestState.loading,
      this.requestStateTVShows = RequestState.loading,
      this.errorMessage = "",
      this.dataSource = DataSource.remote});

  PopularPersonDetailsState copyWith({
    PopularPersonDetailsEntity? popularPersonDetailsEntity,
    RequestState? requestState,
    RequestState? requestStateImages,
    RequestState? requestStateMovies,
    RequestState? requestStateTVShows,
    String? errorMessage,
    DataSource? dataSource,
  }) {
    return PopularPersonDetailsState(
        popularPersonDetailsEntity:
            popularPersonDetailsEntity ?? this.popularPersonDetailsEntity,
        requestState: requestState ?? this.requestState,
        requestStateImages: requestStateImages ?? this.requestStateImages,
        requestStateMovies: requestStateMovies ?? this.requestStateMovies,
        requestStateTVShows: requestStateTVShows ?? this.requestStateTVShows,
        errorMessage: errorMessage ?? this.errorMessage,
        dataSource: dataSource ?? this.dataSource);
  }

  @override
  List<Object> get props => [
        requestState,
        requestStateImages,
        requestStateMovies,
        requestStateTVShows,
        errorMessage,
        dataSource
      ];
}
