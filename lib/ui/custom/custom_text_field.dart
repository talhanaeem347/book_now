import 'package:book_now/app_constants/app_colors.dart';
import 'package:book_now/app_constants/app_padding.dart';
import 'package:book_now/app_constants/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextInputType? keyboardType;
  final bool isPassword;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomTextField(
      {super.key,
      required this.label,
      this.onChanged,
      this.keyboardType,
      this.validator,
      this.isPassword = false,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.only(left: AppPadding.small),
            child: Text(label, style: AppStyle.labelStyle)),
        const SizedBox(height: AppPadding.small),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppPadding.small),
            color: AppColor.lightGrey,
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.normal),
          child: TextFormField(
              obscureText: isPassword,
              controller: controller,
              style: AppStyle.textFieldStyle,
              onChanged: onChanged,
              keyboardType: keyboardType,
              validator: validator ?? (value) => null,
              decoration: const InputDecoration(
                border: InputBorder.none,
              )),
        ),
      ],
    );
  }
}
