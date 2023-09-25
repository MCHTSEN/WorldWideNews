// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:news_app/product/utilities/base/base_firebase_model.dart';

@immutable
class VersionNuberModel extends Equatable
    with IdModel, BaseFirebaseModel<VersionNuberModel> {
  VersionNuberModel({
    this.number,
  });

  final String? number;

  @override
  List<Object?> get props => [number];

  VersionNuberModel copyWith({
    String? number,
  }) {
    return VersionNuberModel(
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
    };
  }

  @override
  VersionNuberModel fromJson(Map<String, dynamic> json) {
    return VersionNuberModel(
      number: json['number'] as String?,
    );
  }

  @override
  // TODO: implement id
 final String? id = '';
}
