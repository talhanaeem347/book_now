import 'package:book_now/app_constants/app_colors.dart';
import 'package:book_now/app_constants/app_strings.dart';
import 'package:book_now/app_constants/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar(BuildContext context, {required String title, required IconData icon, void Function()? onPressed}) {
  return AppBar(
      backgroundColor: AppColor.blue,
      title:  Text(AppStrings.appName,style: AppStyle.headingStyle.copyWith(color: AppColor.white),),

  actions: [
  IconButton(
  onPressed: onPressed,
  icon: Icon(icon, color: AppColor.white, size: 30,),
  ),

  ],
  );
}