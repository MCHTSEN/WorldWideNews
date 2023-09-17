// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:news_app/product/enums/firebase_collection.dart';
import 'package:news_app/product/models/news_model.dart';
import 'package:news_app/product/models/tags_model.dart';

import 'package:news_app/product/utilities/database/firebase_utilty.dart';

class HomeNotifier extends StateNotifier<HomeState> with FirebaseUtilty {
  HomeNotifier() : super(const HomeState());

  // Basic fetch operation

  Future<void> fetchNews() async {
    final newsCollectionReference = FirebaseColletions.news.reference;

    final response = await newsCollectionReference
        .withConverter(
          fromFirestore: (snapshot, options) =>
              const News().fromFirebase(snapshot),
          toFirestore: (value, options) => value.toJson(),
        )
        .get();

    if (response.docs.isNotEmpty) {
      final values = response.docs.map((e) => e.data()).toList();
      state = state.copyWith(news: values);
    }
  }

////// Advence fetch operation
  Future<void> fetchTags() async {
    final values =
        await fetchList<Tags, Tags>(FirebaseColletions.tags, const Tags());
    state = state.copyWith(tags: values);
  }

  Future<void> fetchWithLoading() async {
    state = state.copyWith(isLoading: true);
    await fetchNews();
    await fetchTags();
    state = state.copyWith(isLoading: false);
  }
}

class HomeState extends Equatable {
  const HomeState({
    this.news,
    this.isLoading,
    this.tags,
  });

  final List<News>? news;
  final bool? isLoading;
  final List<Tags>? tags;

  // TODO: implement props

  HomeState copyWith({
    List<News>? news,
    bool? isLoading,
    List<Tags>? tags,
  }) {
    return HomeState(
      news: news ?? this.news,
      isLoading: isLoading ?? this.isLoading,
      tags: tags ?? this.tags,
    );
  }

  @override
  List<Object?> get props => [news, isLoading, tags];
}
