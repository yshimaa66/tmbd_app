part of 'popular_person_details_bloc.dart';

@immutable
class PopularPersonDetailsState extends Equatable {
  final PopularPersonDetailsEntity? popularPersonDetailsEntity;
  final RequestState requestState;
  final String errorMessage;
  final DataSource dataSource;

  PopularPersonDetailsState(
      {this.popularPersonDetailsEntity,
      this.requestState = RequestState.loading,
      this.errorMessage = "",
      this.dataSource = DataSource.remote});

  PopularPersonDetailsState copyWith({
    PopularPersonDetailsEntity? popularPersonDetails,
    RequestState? requestState,
    String? errorMessage,
    DataSource? dataSource,
  }) {
    return PopularPersonDetailsState(
        popularPersonDetailsEntity: popularPersonDetails ?? this.popularPersonDetailsEntity,
        requestState: requestState ?? this.requestState,
        errorMessage: errorMessage ?? this.errorMessage,
        dataSource: dataSource ?? this.dataSource);
  }

  @override
  List<Object> get props =>
      [popularPersonDetailsEntity!, requestState, errorMessage, dataSource];
}
