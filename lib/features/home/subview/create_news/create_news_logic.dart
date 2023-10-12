import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartal/kartal.dart';
import 'package:news_app/product/constants/app_strings.dart';
import 'package:news_app/product/enums/firebase_collection.dart';
import 'package:news_app/product/models/category_model.dart';
import 'package:news_app/product/utilities/database/firebase_utilty.dart';
import 'package:news_app/product/utilities/package/util_image_picker.dart';

class CreateNewsLogic with FirebaseUtilty {
  final TextEditingController titleController = TextEditingController();
  CategoryModel? _categoryModel;
  List<CategoryModel> _categories = [];
  Uint8List? _selectedFileBytes;
  Uint8List? get selectedFileBytes => _selectedFileBytes;
  bool _isValidateAllForm = false;
  bool get isValidateAllForm => _isValidateAllForm;
  List<CategoryModel> get categories => _categories;
  XFile? _selectedFile;

  final GlobalKey<FormState> formKey = GlobalKey();

  void updateCategory(CategoryModel categoryModel) {
    _categoryModel = categoryModel;
  }

  bool checkAllValidate(ValueSetter<bool> onUpdate) {
    final value = formKey.currentState?.validate() ?? false;

    if (value != _isValidateAllForm && selectedFileBytes != null) {
      _isValidateAllForm = value;
      onUpdate.call(value);
    }
    return isValidateAllForm;
  }

  Future<void> pickAndCheck(ValueSetter<bool> onUpdate) async {
    _selectedFile = await UtilImagePicker().pickImage();
    _selectedFileBytes = await _selectedFile?.readAsBytes();
    checkAllValidate(
      (value) {},
    );
    onUpdate.call(true);
  }

  Future<List<CategoryModel>?> fetchAllCategories() async {
    final response = await fetchList<CategoryModel, CategoryModel>(
      FirebaseColletions.category,
      CategoryModel(),
    );
    _categories = response ?? [];
    return null;
  }

  String? checkValidate(String? value) {
    if (value.isNullOrEmpty || value == null) {
      return AppStrings.homeCreateValidMessage;
    }
    return null;
  }

  void dispose() {
    titleController.dispose();
    _categoryModel = null;
  }
}
