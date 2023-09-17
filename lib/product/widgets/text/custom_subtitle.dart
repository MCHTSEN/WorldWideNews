import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomSubTitle extends StatelessWidget {
  const CustomSubTitle({required this.value, super.key, this.color});
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: context.textTheme.bodyMedium?.copyWith(color: color),
    );
  }
}
