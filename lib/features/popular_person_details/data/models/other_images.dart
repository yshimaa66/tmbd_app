import 'package:equatable/equatable.dart';

class OtherImages extends Equatable {
  int? id;
  List<Profiles>? profiles;

  OtherImages({this.id, this.profiles});

  OtherImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['profiles'] != null) {
      profiles = <Profiles>[];
      json['profiles'].forEach((v) {
        profiles!.add(new Profiles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.profiles != null) {
      data['profiles'] = this.profiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List get props => [id, profiles];
}

class Profiles extends Equatable{
  double? aspectRatio;
  int? height;
  Null? iso6391;
  String? filePath;
  double? voteAverage;
  int? voteCount;
  int? width;

  Profiles(
      {this.aspectRatio,
      this.height,
      this.iso6391,
      this.filePath,
      this.voteAverage,
      this.voteCount,
      this.width});

  Profiles.fromJson(Map<String, dynamic> json) {
    aspectRatio = json['aspect_ratio'];
    height = json['height'];
    iso6391 = json['iso_639_1'];
    filePath = json['file_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aspect_ratio'] = this.aspectRatio;
    data['height'] = this.height;
    data['iso_639_1'] = this.iso6391;
    data['file_path'] = this.filePath;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    data['width'] = this.width;
    return data;
  }

  @override
  List get props => [
    aspectRatio,
    height,
    iso6391,
    filePath,
    voteAverage,
    voteCount,
    width
  ];
}
