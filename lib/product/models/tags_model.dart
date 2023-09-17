import 'package:equatable/equatable.dart';
import 'package:news_app/product/utilities/base/base_firebase_model.dart';

class Tags with EquatableMixin, IdModel, BaseFirebaseModel<Tags> {
  const Tags({
    this.id,
    this.isActive,
    this.name,
  });

  factory Tags.fromJson(Map<String, dynamic> json) {
    return Tags(
      isActive: json['isActive'] as bool?,
      name: json['name'] as String?,
    );
  }
  final bool? isActive;
  final String? name;

  @override
  // TODO: implement id
  final String? id;

  @override
  List<Object?> get props => [isActive, name];

  Tags copyWith({
    bool? isActive,
    String? name,
  }) {
    return Tags(
      isActive: isActive ?? this.isActive,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isActive': isActive,
      'name': name,
    };
  }

  @override
  Tags fromJson(Map<String, dynamic> json) {
    return Tags(
      isActive: json['isActive'] as bool?,
      name: json['name'] as String?,
    );
  }
}
