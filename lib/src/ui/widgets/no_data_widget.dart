import 'package:flutter/material.dart';
import 'package:orbi_test/src/config/colors.dart';
import 'package:orbi_test/src/config/images.dart';
import 'package:orbi_test/src/ui/widgets/text_widget.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Image(
            image: AppImages.empty,
            opacity: AlwaysStoppedAnimation(.6),
          ),
          TextWidget(
            text: text,
            style: TextStyles.titleSmall,
            color: AppColors.primary.withOpacity(0.5),
          )
        ],
      ),
    );
  }
}
