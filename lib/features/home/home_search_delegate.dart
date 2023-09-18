import 'package:flutter/material.dart';

import 'package:news_app/product/models/tags_model.dart';

class HomeSearchDelegate extends SearchDelegate<Tags?> {
  HomeSearchDelegate(this.tagItems);

  final List<Tags>? tagItems;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final response = tagItems?.where(
      (element) =>
          element.name?.toLowerCase().contains(query.toLowerCase()) ?? false,
    );

    return ListView.builder(
      itemCount: response?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            onTap: () {
              query = response?.elementAt(index).name ?? '';
              close(context, response?.elementAt(index));
            },
            leading: const Icon(Icons.arrow_outward_sharp),
            title: Text(response?.elementAt(index).name ?? ''),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final response = tagItems?.where(
      (element) =>
          element.name?.toLowerCase().contains(query.toLowerCase()) ?? false,
    );

    return ListView.builder(
      itemCount: response?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            onTap: () {
              query = response?.elementAt(index).name ?? '';
              close(context, response?.elementAt(index));
            },
            leading: const Icon(Icons.arrow_outward_sharp),
            title: Text(response?.elementAt(index).name ?? ''),
          ),
        );
      },
    );
  }
}
