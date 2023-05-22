// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

const String _imagePath = 'assets/images';

class _Image extends AssetImage {
  const _Image(String fileName) : super('$_imagePath/$fileName');
}

class AppImages {
  static const empty = _Image('empty.png');
  static const ornament = _Image('ornament.png');
  static const dots = _Image('dots.png');
  static const female = _Image('female.png');
  static const male = _Image('male.png');

  static Future<void> precacheAssets(BuildContext context) async {
    await precacheImage(ornament, context);
    await precacheImage(empty, context);
    await precacheImage(dots, context);
    await precacheImage(female, context);
    await precacheImage(male, context);
  }
}
