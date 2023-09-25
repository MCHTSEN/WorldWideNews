import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/product/enums/firebase_collection.dart';
import 'package:news_app/product/models/category_model.dart';
import 'package:news_app/product/utilities/database/firebase_utilty.dart';

class CreateNewsLogic with FirebaseUtilty {
  final TextEditingController titleController = TextEditingController();
  CategoryModel? _categoryModel;
  List<CategoryModel> _categories = [];
  Uint8List? _selectedFileBytes;
  Uint8List? get selectedFileBytes => _selectedFileBytes;

  List<CategoryModel> get categories => _categories;

  final GlobalKey<FormState> formKey = GlobalKey();

  void updateCategory(CategoryModel categoryModel) {
    _categoryModel = categoryModel;
  }

  Future<List<CategoryModel>?> fetchAllCategories() async {
    final response = await fetchList<CategoryModel, CategoryModel>(
      FirebaseColletions.category,
      CategoryModel(),
    );
    _categories = response ?? [];
    return null;
  }

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    _selectedFileBytes = await image?.readAsBytes();
  }

  void dispose() {
    titleController.dispose();
    _categoryModel = null;
  }
}
