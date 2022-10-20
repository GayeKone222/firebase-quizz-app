import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppCircleButton extends StatelessWidget {
  const AppCircleButton(
      {Key? key,
      required this.child,
      this.color,
       this.width,
      required this.onTap})
      : super(key: key);

  final Widget child;
  final Color? color;
  final double? width;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      clipBehavior: Clip.hardEdge,
        shape: const CircleBorder(),
        child: InkWell(
          onTap:  onTap,
          child: child,
        ));
  }
}
