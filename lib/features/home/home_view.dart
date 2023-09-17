import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:news_app/product/constants/app_strings.dart';
import 'package:news_app/product/constants/colors_constants.dart';
import 'package:news_app/product/widgets/text/custom_subtitle.dart';
import 'package:news_app/product/widgets/text/custom_title.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final dummyImage =
      'https://firebasestorage.googleapis.com/v0/b/news-app-5a982.appspot.com/o/BMW_logo_(gray).png?alt=media&token=a8c5f30e-aee9-4b87-9918-0bf727564360';
  final dummyNewsTitle = 'AUTOMOTIVE';
  final dummyNewsDescription =
      'Electric car sales increased by %35 in the last quarter of 2023';

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTitle(value: AppStrings.homeBrowse),
              const CustomSubTitle(value: AppStrings.homeBrowseDetail),
              _empty(),
              _SearchBar(),
              _Chips(),
              _MainNews(),
              _empty(),
              _RecommendedTitle(),
              _RecommendedForYou(),
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

  SizedBox _MainNews() {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: context.paddingNormal,
            child: SizedBox(
              height: 300,
              width: 300,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                    child: Container(
                      decoration: const BoxDecoration(),
                      height: 300,
                      width: 300,
                      child: Image.network(
                        'https://picsum.photos/200',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                    child: Opacity(
                      opacity: 0.5,
                      child: Container(
                        height: 300,
                        width: 300,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_border_outlined,
                        color: ColorConstants.white,
                        size: 36,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding: context.paddingNormal,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dummyNewsTitle,
                            style: context.textTheme.titleSmall?.copyWith(
                              color: ColorConstants.white,
                            ),
                          ),
                          Text(
                            dummyNewsDescription,
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
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
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: ChoiceChip(
              label: Text('Chip $index'),
              selected: selectedChipIndex == index,
              onSelected: (selected) {
                selectChip(selected ? index : 0);
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
