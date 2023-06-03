import 'dart:core';

import 'package:equatable/equatable.dart';

class PopularPersonEntity extends Equatable {
  int? id;
  String? name, knownForDepartment, profilePath;

  PopularPersonEntity(
      {this.id = -1,
      this.name = "",
      this.knownForDepartment = "",
      this.profilePath = ""});

  PopularPersonEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    knownForDepartment = json['knownForDepartment'];
    profilePath = json["profilePath"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['knownForDepartment'] = this.knownForDepartment;
    data['profilePath'] = this.profilePath;
    return data;
  }

  @override
  List<Object> get props => [id!, name!, knownForDepartment!, profilePath!];
}
