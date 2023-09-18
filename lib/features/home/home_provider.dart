// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:news_app/product/enums/firebase_collection.dart';
import 'package:news_app/product/models/news_model.dart';
import 'package:news_app/product/models/recommended_model.dart';
import 'package:news_app/product/models/tags_model.dart';
import 'package:news_app/product/utilities/database/firebase_utilty.dart';

class HomeNotifier extends StateNotifier<HomeState> with FirebaseUtilty {
  HomeNotifier() : super(const HomeState());

  late List<Tags> _fullTagList;

  List<Tags> get fullTagList => _fullTagList;

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
    _fullTagList = state.tags ?? [];
  }

  Future<void> fetchRecommended() async {
    final values = await fetchList<Recommended, Recommended>(
      FirebaseColletions.recommended,
      Recommended(),
    );
    state = state.copyWith(recommendeds: values);
  }

  Future<void> fetchWithLoading() async {
    state = state.copyWith(isLoading: true);
    await Future.wait([fetchNews(), fetchTags(), fetchRecommended()]);
    state = state.copyWith(isLoading: false);
  }

  void updateTag(Tags? tag) {
    if (tag == null) return;
    state = state.copyWith(selectedTag: tag);
  }
}

class HomeState extends Equatable {
  const HomeState({
    this.news,
    this.isLoading,
    this.tags,
    this.recommendeds,
    this.selectedTag,
  });
  final List<Recommended>? recommendeds;
  final List<News>? news;
  final bool? isLoading;
  final List<Tags>? tags;
  final Tags? selectedTag;

  // TODO: implement props

  HomeState copyWith({
    List<Recommended>? recommendeds,
    List<News>? news,
    bool? isLoading,
    List<Tags>? tags,
    Tags? selectedTag,
  }) {
    return HomeState(
      recommendeds: recommendeds ?? this.recommendeds,
      news: news ?? this.news,
      isLoading: isLoading ?? this.isLoading,
      tags: tags ?? this.tags,
      selectedTag: selectedTag ?? this.selectedTag,
    );
  }

  @override
  List<Object?> get props => [recommendeds, news, isLoading, tags, selectedTag];
}
