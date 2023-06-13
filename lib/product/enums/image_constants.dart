import 'package:flutter/material.dart';

enum ImageConstants {
  logo('app_logo');

  final String path;
  const ImageConstants(this.path);

  String get toPng => 'assets/icons/$path.png';
  Image get toImage => Image.asset(toPng);
}
