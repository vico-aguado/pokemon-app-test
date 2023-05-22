import 'package:flutter/material.dart';
import 'package:orbi_test/src/ui/widgets/text_widget.dart';

class ChipWidget extends StatelessWidget {
  const ChipWidget({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15,
      padding: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        backgroundBlendMode: BlendMode.screen,
        borderRadius: BorderRadius.circular(15),
        color: Colors.white.withOpacity(0.3),
      ),
      child: TextWidget(
        text: text,
        style: TextStyles.displayMedium,
      ),
    );
  }
}
