import 'package:firebase_study_app/core/configs/themes/custom_test_styles.dart';
import 'package:firebase_study_app/core/configs/themes/ui_parameters.dart';
import 'package:firebase_study_app/core/utils/app_icons.dart';
import 'package:firebase_study_app/features/presentation/widgets/common_widgets/app_circle_button.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {Key? key,
      this.title = "",
      this.titleWidget,
      this.leading,
      this.showActionIcon = false,
      this.onMenuActionTap})
      : super(key: key);

  final String title;
  final Widget? titleWidget;
  final Widget? leading;
  final bool showActionIcon;
  final VoidCallback? onMenuActionTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(mobileScreenPadding),
        child: Stack(children: [
          Positioned.fill(
              child: titleWidget == null
                  ? Center(
                      child: Text(
                      title,
                      style: appBarTS,
                    ))
                  : Center(
                      child: titleWidget,
                    )),
          Positioned.fill(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              leading ?? const BackButton(),
              if (showActionIcon)
                AppCircleButton(
                    onTap: onMenuActionTap??(){},
                    child: const Icon(AppIcons.menu))
            ],
          ))
        ]),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 80);
}
