import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:news_app/features/home/home_provider.dart';
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
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(_homeProvider.notifier).fetchWithLoading();
    });
  }

  final dummyImage =
      'https://firebasestorage.googleapis.com/v0/b/news-app-5a982.appspot.com/o/BMW_logo_(gray).png?alt=media&token=a8c5f30e-aee9-4b87-9918-0bf727564360';
  final String dummySubtitle = 'A simple Trick For beginners';
  final String dummyTitle = 'UI/UX Desing';

  int selectedChipIndex = -1;

  void selectChip(int index) {
    setState(() {
      selectedChipIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  _SearchBar(),
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

  ClipRRect _SearchBar() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(18)),
      child: SizedBox(
        height: 70,
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            fillColor: ColorConstants.unSelected,
            filled: true,
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            prefix: const Icon(
              Icons.search,
              size: 20,
            ),
            suffix: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.mic_none_rounded,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded _RecommendedForYou() {
    return Expanded(
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: context.onlyBottomPaddingNormal,
            child: Row(
              children: [
                Image.network(
                  dummyImage,
                  width: 75,
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      dummyTitle,
                      style: context.textTheme.bodyLarge
                          ?.copyWith(color: Colors.grey),
                    ),
                    subtitle: Text(
                      dummySubtitle,
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
        const CustomTitle(value: AppStrings.homeRecommended),
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
