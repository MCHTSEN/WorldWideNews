import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({required this.value, super.key, this.color});
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: context.textTheme.headlineMedium
          ?.copyWith(color: color, fontWeight: FontWeight.bold),
    );
  }
}
