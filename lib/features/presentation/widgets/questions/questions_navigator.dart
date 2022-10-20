import 'package:firebase_study_app/core/configs/themes/app_colors.dart';
import 'package:firebase_study_app/core/configs/themes/ui_parameters.dart';
import 'package:firebase_study_app/features/presentation/widgets/common_widgets/main_button.dart';
import 'package:flutter/material.dart';

class QuestionsNavigator extends StatelessWidget {
  const QuestionsNavigator(
      {Key? key,
      required this.previous,
      required this.next,
      this.showPreviousIcon = false,
      this.isCompleted = false,
      required this.complete})
      : super(key: key);
  final VoidCallback previous;
  final VoidCallback next;
  final VoidCallback complete;
  final bool showPreviousIcon;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UIParameters.mobileScreenpadding.copyWith(),
      child: Row(
        children: [
          Visibility(
              visible: showPreviousIcon,
              child: InkWell(
                borderRadius: UIParameters.cardCircularBorderRadius,
                onTap: previous,
                child: Ink(
                  padding: UIParameters.mobileScreenpadding,
                  decoration: BoxDecoration(
                      borderRadius: UIParameters.cardCircularBorderRadius,
                      color: onSurfaceTextColor),
                  //  height: 55,
                  //  width: 55,
                  child:const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  ),
                ),
              )),
          const SizedBox(
            width: 5,
          ),
          Expanded(
              child: MainButton(
            onTap: isCompleted ? complete : next,
            title: isCompleted ? "Complete" : "Next",
            color: onSurfaceTextColor,
          )

              // InkWell(
              //   onTap:isCompleted ? complete : next,
              //   child: Text(
              //     isCompleted ? "Complete" : "Next",
              //     style: TextStyle(color: Theme.of(context).primaryColor),
              //   ),
              // ),
              )
        ],
      ),
    );
  }
}
