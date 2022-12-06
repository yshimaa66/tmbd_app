part of 'popular_person_image_view_bloc.dart';

@immutable
abstract class PopularPersonImageViewEvent extends Equatable{
  const PopularPersonImageViewEvent();
}

class Prepare extends PopularPersonImageViewEvent {
  const Prepare();

  @override
  List<Object?> get props => [];
}

class RequestDownload extends PopularPersonImageViewEvent {
  final String imageUrl;
  const RequestDownload(this.imageUrl);

  @override
  List<Object?> get props => [imageUrl];
}