import 'package:flutter/material.dart';
import 'package:orbi_test/src/ui/widgets/text_widget.dart';

class ContentInfoWidget extends StatelessWidget {
  const ContentInfoWidget({
    super.key,
    required this.content,
    required this.title,
  });
  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: title,
            style: TextStyles.labelLarge,
          ),
          const SizedBox(
            height: 20,
          ),
          content
        ],
      ),
    );
  }
}
