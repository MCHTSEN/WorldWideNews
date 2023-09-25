import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:news_app/features/home/home_provider.dart';
import 'package:news_app/features/home/home_search_delegate.dart';
import 'package:news_app/features/home/subview/create_news/create_news_logic.dart';
import 'package:news_app/features/home/subview/create_news/create_news_view.dart';
import 'package:news_app/product/constants/app_strings.dart';
import 'package:news_app/product/constants/colors_constants.dart';
import 'package:news_app/product/widgets/card/home_news_card.dart';
import 'package:news_app/product/widgets/text/custom_subtitle.dart';
import 'package:news_app/product/widgets/text/custom_title.dart';

final _homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(_homeProvider.notifier).fetchWithLoading();
    });
    ref.read(_homeProvider.notifier).addListener((state) {
      _controller.text = state.selectedTag?.name ?? '';
    });
  }

  int selectedChipIndex = -1;
  void selectChip(int index) {
    setState(() {
      selectedChipIndex = index;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.navigateToPage(const CreateNews());
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: context.paddingNormal,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomTitle(value: AppStrings.homeBrowse),
                  const CustomSubTitle(value: AppStrings.homeBrowseDetail),
                  _empty(),
                  _SearchBar(_controller),
                  _Chips(),
                  const SizedBox(
                    height: 300,
                    child: _MainNews(),
                  ),
                  _empty(),
                  _RecommendedTitle(),
                  _RecommendedForYou(),
                ],
              ),
              if (ref.watch(_homeProvider).isLoading ?? false)
                const Center(child: CircularProgressIndicator())
            ],
          ),
        ),
      ),
    );
  }

  Expanded _RecommendedForYou() {
    final recommendeds = ref.watch(_homeProvider).recommendeds ?? [];
    return Expanded(
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        itemCount: recommendeds.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: context.onlyBottomPaddingNormal,
            child: Row(
              children: [
                Image.network(
                  recommendeds[index].image ?? '',
                  width: 75,
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      recommendeds[index].title ?? '',
                      style: context.textTheme.bodyLarge
                          ?.copyWith(color: Colors.grey),
                    ),
                    subtitle: Text(
                      recommendeds[index].description ?? '',
                      style: context.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  SizedBox _empty() {
    return const SizedBox(
      height: 40,
    );
  }

  Row _RecommendedTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Expanded(child: CustomTitle(value: AppStrings.homeRecommended)),
        TextButton(
          onPressed: () {},
          child: const Text(AppStrings.homeSeeAll),
        ),
      ],
    );
  }

  SizedBox _Chips() {
    final tags = ref.watch(_homeProvider).tags ?? [];
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tags.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: ChoiceChip(
              label: Text(tags[index].name ?? ''),
              selected: selectedChipIndex == index,
              onSelected: (selected) {
                selectChip(index);
              },
              selectedColor: ColorConstants.selected,
              backgroundColor: ColorConstants.unSelected,
            ),
          );
        },
      ),
    );
  }
}

class _SearchBar extends ConsumerWidget {
  const _SearchBar(this.controller);
  final TextEditingController controller;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SearchBar(
      controller: controller,
      backgroundColor: MaterialStateColor.resolveWith(
        (states) => ColorConstants.white,
      ),
      onTap: () async {
        final result = await showSearch(
          context: context,
          delegate: HomeSearchDelegate(
            ref.read(_homeProvider.notifier).fullTagList,
          ),
        );
        ref.read(_homeProvider.notifier).updateTag(result);
      },
      hintText: AppStrings.homeSearchHint,
      trailing: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.mic),
        )
      ],
    );
  }
}

class _MainNews extends ConsumerWidget {
  const _MainNews();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final news = ref.watch(_homeProvider).news ?? [];
    return ListView.builder(
      itemCount: news.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: context.paddingNormal,
          child: SizedBox(
            height: 300,
            width: 300,
            child: HomeNewsCard(
              newsItem: news[index],
            ),
          ),
        );
      },
    );
  }
}
