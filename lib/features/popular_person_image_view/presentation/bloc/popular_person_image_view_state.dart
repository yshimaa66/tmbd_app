part of 'popular_person_image_view_bloc.dart';

@immutable
class PopularPersonImageViewState extends Equatable {
  final bool permissionReady;
  final String localPath;
  final ReceivePort port = ReceivePort();

  PopularPersonImageViewState(
      {this.permissionReady = false,
      this.localPath = ""});

  PopularPersonImageViewState copyWith({
    RequestState? requestState,
    String? errorMessage,
    bool? permissionReady,
    String? localPath,
    int? photoDownloadProgress,
  }) {
    return PopularPersonImageViewState(
        permissionReady: permissionReady ?? this.permissionReady,
        localPath: localPath ?? this.localPath);
  }

  @override
  List<Object> get props =>
      [permissionReady, localPath];
}
