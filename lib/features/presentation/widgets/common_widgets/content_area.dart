import 'package:firebase_study_app/core/configs/themes/app_colors.dart';
import 'package:firebase_study_app/core/configs/themes/ui_parameters.dart';
import 'package:flutter/material.dart';

class ContentArea extends StatelessWidget {
  const ContentArea({Key? key, this.addpadding = true, required this.child})
      : super(key: key);

  final bool addpadding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      clipBehavior: Clip.hardEdge,
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(color: customScaffoldColor(context)),
        padding: addpadding
            ? EdgeInsets.only(top: mobileScreenPadding, left:mobileScreenPadding, right: mobileScreenPadding )
            : EdgeInsets.zero,
            child: child,
      ),
    );
  }
}
