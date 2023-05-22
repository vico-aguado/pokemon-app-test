import 'package:flutter/material.dart';
import 'package:orbi_test/src/config/images.dart';

class BackgroundImagesWidget extends StatelessWidget {
  const BackgroundImagesWidget({
    super.key,
    required this.safeArea,
    required this.scrollPosition,
  });
  final EdgeInsets safeArea;
  final double scrollPosition;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Image(image: AppImages.ornament),
        const Spacer(),
        Opacity(
          opacity: scrollPosition,
          child: Padding(
            padding: EdgeInsets.only(top: safeArea.top - 5),
            child: const Image(
              image: AppImages.dots,
              opacity: AlwaysStoppedAnimation(0.7),
              height: 30,
            ),
          ),
        ),
        const SizedBox(
          width: 80,
        )
      ],
    );
  }
}
