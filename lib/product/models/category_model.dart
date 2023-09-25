// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:news_app/product/utilities/base/base_firebase_model.dart';

class CategoryModel extends Equatable
    with IdModel, BaseFirebaseModel<CategoryModel> {
  CategoryModel({
    this.name,
    this.detail,
    this.id,
  });

  final String? name;
  final String? detail;
  @override
  final String? id;

  @override
  List<Object?> get props => [name, detail, id];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'detail': detail,
    };
  }

  @override
  CategoryModel fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'] as String?,
      detail: json['detail'] as String?,
    );
  }

  CategoryModel copyWith({
    String? name,
    String? detail,
    String? id,
  }) {
    return CategoryModel(
      name: name ?? this.name,
      detail: detail ?? this.detail,
      id: id ?? this.id,
    );
  }
}
