import 'package:equatable/equatable.dart';
import 'package:news_app/product/utilities/base/base_firebase_model.dart';

class Recommended extends Equatable
    with IdModel, BaseFirebaseModel<Recommended> {
  Recommended({
    this.title,
    this.description,
    this.image,
  });

  factory Recommended.fromJson(Map<String, dynamic> json) {
    return Recommended(
      title: json['title'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
    );
  }
  String? title;
  String? description;
  String? image;

  @override
  List<Object?> get props => [title, description, image];

  Recommended copyWith({
    String? title,
    String? description,
    String? image,
  }) {
    return Recommended(
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'image': image,
    };
  }

  @override
  Recommended fromJson(Map<String, dynamic> json) {
    return Recommended(
      title: json['title'] as String?,
      image: json['image'] as String?,
      description: json['description'] as String?,
    );
  }

  @override
  // TODO: implement id
  String? get id => '';
}
