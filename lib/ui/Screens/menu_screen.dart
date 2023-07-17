import 'package:book_now/app_constants/app_colors.dart';
import 'package:book_now/app_constants/app_padding.dart';
import 'package:book_now/app_constants/app_strings.dart';
import 'package:book_now/app_constants/app_text_style.dart';
import 'package:book_now/bloc/menu/menu_bloc.dart';
import 'package:book_now/ui/custom/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  MenuBloc _menuBloc(BuildContext context) =>
      BlocProvider.of<MenuBloc>(context);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenuBloc(),
      child: BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) {
          if (state is MenuInitial) {
            _menuBloc(context).add(OpenMenu());
            return Container();
          }
          else if (state is MenuOpen) {
            return Scaffold(
              appBar: customAppBar(context,
                  title: AppStrings.appName, icon: Icons.close, onPressed: () {
                    _menuBloc(context).add(CloseMenu());
                  }),
              backgroundColor: AppColor.lightGrey,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.all(AppPadding.large),
                      child: Text(
                        AppStrings.menu,
                        style: AppStyle.headingStyle.copyWith(
                            color: AppColor.blue,
                            fontSize: AppPadding.large * 2),
                      )),
                  Container(
                      padding: const EdgeInsets.all(AppPadding.large),
                      child: Text(
                        AppStrings.contactUs,
                        style: AppStyle.headingStyle.copyWith(
                            color: AppColor.blue,
                            fontSize: AppPadding.extraLarge),
                      )),
                  Container(
                      padding: const EdgeInsets.all(AppPadding.large),
                      child: Text(
                        AppStrings.faq,
                        style: AppStyle.headingStyle.copyWith(
                            color: AppColor.blue,
                            fontSize: AppPadding.extraLarge),
                      )),
                  Container(
                      padding: const EdgeInsets.all(AppPadding.large),
                      child: Text(
                        AppStrings.airLineInformation,
                        style: AppStyle.headingStyle.copyWith(
                            color: AppColor.blue,
                            fontSize: AppPadding.extraLarge),
                      )),
                ],
              ),
            );
          }
           if (state is MenuClose) {
             Navigator.pop(context);
          }
          return Container();
        },
      ),
    );
  }
}
