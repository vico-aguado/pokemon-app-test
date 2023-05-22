import 'package:flutter/material.dart';
import 'package:orbi_test/src/config/colors.dart';
import 'package:orbi_test/src/ui/widgets/text_widget.dart';

class LinearBarWidget extends StatelessWidget {
  const LinearBarWidget({
    super.key,
    required this.title,
    required this.value,
    required this.number,
  });

  final String title;
  final String number;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TextWidget(
              text: title,
              color: AppColors.primary.withOpacity(0.4),
              style: TextStyles.labelMedium,
            ),
          ),
          Expanded(
            child: TextWidget(
              textAlign: TextAlign.center,
              text: number,
              style: TextStyles.labelMedium,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            flex: 5,
            child: SizedBox(
              height: 4,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  AnimatedContainer(
                    width: value * 2.25,
                    decoration: BoxDecoration(
                      color: value > 50 ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    duration: const Duration(milliseconds: 400),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
