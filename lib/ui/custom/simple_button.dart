import 'package:book_now/app_constants/app_colors.dart';
import 'package:book_now/app_constants/app_padding.dart';
import 'package:book_now/app_constants/app_text_style.dart';
import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  final bool isEnable;

  const SimpleButton(
      {super.key, required this.label, this.onPressed, required this.isEnable});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppPadding.extraLarge * 2,
      decoration: BoxDecoration(
        color: isEnable
            ? AppColor.blue.withOpacity(0.8)
            : AppColor.blue.withOpacity(0.4),
        borderRadius:
            const BorderRadius.all(Radius.circular(AppPadding.normal)),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(label,
            style: AppStyle.subHeadingStyle.copyWith(
              color: AppColor.white,
            )),
      ),
    );
  }
}
