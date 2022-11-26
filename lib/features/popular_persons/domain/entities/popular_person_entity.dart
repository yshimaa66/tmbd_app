import 'dart:core';

import 'package:equatable/equatable.dart';

class PopularPersonEntity extends Equatable {
  final int id;
  final String name, knownForDepartment, profilePath;

  const PopularPersonEntity(
      {this.id = -1,
      this.name = "",
      this.knownForDepartment = "",
      this.profilePath = ""});

  @override
  List<Object> get props => [id, name, knownForDepartment, profilePath];
}
