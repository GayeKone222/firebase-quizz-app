import 'package:firebase_study_app/core/configs/themes/ui_parameters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainButton extends StatelessWidget {
  const MainButton(
      {Key? key, required this.onTap, required this.title, this.color})
      : super(key: key);

  final VoidCallback onTap;
  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: UIParameters.cardCircularBorderRadius,
      onTap: onTap,
      child: Ink(
        padding: UIParameters.mobileScreenpadding,
        decoration: BoxDecoration(
            borderRadius: UIParameters.cardCircularBorderRadius, color: color),
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }
}
