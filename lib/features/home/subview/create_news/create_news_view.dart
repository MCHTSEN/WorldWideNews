import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:news_app/features/home/subview/create_news/create_news_logic.dart';
import 'package:news_app/product/constants/app_strings.dart';
import 'package:news_app/product/models/category_model.dart';

class CreateNews extends StatefulWidget {
  const CreateNews({super.key});
  @override
  State<CreateNews> createState() => _CreateNewsState();
}

class _CreateNewsState extends State<CreateNews> {
  late final CreateNewsLogic _homeLogic;

  @override
  void initState() {
    super.initState();
    _homeLogic = CreateNewsLogic();

    _fetchInitialCategory();
  }

  Future<void> _fetchInitialCategory() async {
    await _homeLogic.fetchAllCategories();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create news'),
      ),
      body: Form(
        key: _homeLogic.formKey,
        child: Padding(
          padding: context.paddingLow,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _HomeDropDown(
                  categories: _homeLogic.categories,
                  onChanged: _homeLogic.updateCategory,
                ),
                _empty(),
                TextFormField(
                  controller: _homeLogic.titleController,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
                _empty(),
                SizedBox(
                  height: context.dynamicHeight(0.2),
                  width: context.dynamicWidth(0.9),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: IconButton(
                      onPressed: () async {
                        await _homeLogic.pickImage();
                        setState(() {});
                      },
                      icon: _homeLogic.selectedFileBytes != null
                          ? Image.memory(_homeLogic.selectedFileBytes!)
                          : const Icon(Icons.file_copy),
                    ),
                  ),
                ),
                _empty(),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromHeight(60),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.send_outlined),
                  label: const Text(AppStrings.homeCreateSend),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _empty() {
    return const SizedBox(
      height: 30,
    );
  }
}

class _HomeDropDown extends StatelessWidget {
  const _HomeDropDown({required this.categories, required this.onChanged});

  final List<CategoryModel> categories;
  final ValueSetter<CategoryModel> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<CategoryModel>(
      validator: (value) => value == null ? 'Cannot empty' : null,
      items: categories
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e.name ?? ''),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) return;
        onChanged.call(value);
      },
    );
  }
}
