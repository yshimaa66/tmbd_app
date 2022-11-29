import 'package:equatable/equatable.dart';

class CastEntity extends Equatable {
  String? name, title, posterPath, backdropPath;
  double? voteAverage;
  int? voteCount;

  CastEntity({this.name, this.title, this.posterPath, this.backdropPath,
    this.voteAverage, this.voteCount});

  CastEntity.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    posterPath = json['posterPath'];
    backdropPath = json['backdropPath'];
    voteAverage = json['voteAverage'];
    voteCount = json["voteCount"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.name;
    data['title'] = this.title;
    data['posterPath'] = this.posterPath;
    data['backdropPath'] = this.backdropPath;
    data['voteAverage'] = this.voteAverage;
    data['voteCount'] = this.voteCount;
    return data;
  }


  @override
  List<Object?> get props => [name, voteAverage, voteCount];
}