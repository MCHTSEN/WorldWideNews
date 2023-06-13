import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class FadeText extends StatelessWidget {
  const FadeText({
    super.key,
    this.textFirst,
    this.textSecond,
    this.textThird,
  });
  final String? textFirst;
  final String? textSecond;
  final String? textThird;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 200,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 32,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        child: AnimatedTextKit(
          pause: const Duration(milliseconds: 5),
          repeatForever: true,
          animatedTexts: [
            FadeAnimatedText(textFirst ?? ''),
            FadeAnimatedText(textSecond ?? ''),
            FadeAnimatedText(textThird ?? ''),
          ],
          onTap: () {
            print('Tap Event');
          },
        ),
      ),
    );
  }
}
