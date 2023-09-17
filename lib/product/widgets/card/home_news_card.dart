import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:news_app/features/home/home_provider.dart';
import 'package:news_app/product/constants/colors_constants.dart';

import 'package:news_app/product/models/news_model.dart';

class HomeNewsCard extends ConsumerWidget {
  HomeNewsCard({
    required this.newsItem,
    super.key,
  });

  final News? newsItem;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          child: Container(
            decoration: const BoxDecoration(),
            height: 300,
            width: 300,
            child: Image.network(
              newsItem?.backgroundImage ?? '',
              errorBuilder: (context, error, stackTrace) => const Placeholder(),
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
                  newsItem?.category ?? '',
                  style: context.textTheme.titleSmall?.copyWith(
                    color: ColorConstants.white,
                  ),
                ),
                Text(
                  newsItem?.title ?? '',
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
    );
  }
}
