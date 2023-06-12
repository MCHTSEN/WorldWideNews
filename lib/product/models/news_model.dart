import 'package:equatable/equatable.dart';
import 'package:news_app/product/utilities/base/base_firebase_model.dart';

class News extends Equatable with IdModel, BaseFirebaseModel<News> {
  const News({
    this.title,
    this.backgroundImage,
    this.category,
    this.categoryId,
    this.id,
  });

  final String? title;
  final String? backgroundImage;
  final String? category;
  final String? categoryId;
  @override
  final String? id;

  @override
  List<Object?> get props => [title, backgroundImage, category, categoryId, id];

  News copyWith({
    String? title,
    String? backgroundImage,
    String? category,
    String? categoryId,
    String? id,
  }) {
    return News(
      title: title ?? this.title,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'backgroundImage': backgroundImage,
      'category': category,
      'categoryId': categoryId,
      'id': id,
    };
  }

  @override
  News fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] as String?,
      backgroundImage: json['backgroundImage'] as String?,
      category: json['category'] as String?,
      categoryId: json['categoryId'] as String?,
      id: json['id'] as String?,
    );
  }
}
