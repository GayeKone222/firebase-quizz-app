import 'package:firebase_study_app/core/Routes/routes_name.dart';
import 'package:firebase_study_app/core/configs/themes/app_colors.dart';
import 'package:firebase_study_app/features/presentation/bloc/navigator_bloc/navigator_bloc.dart';
import 'package:firebase_study_app/features/presentation/widgets/common_widgets/app_circle_button.dart';
import 'package:flutter/material.dart';
 
import 'package:flutter_bloc/flutter_bloc.dart';

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: mainGradient(context),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star,
                  size: 65,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "This is a study app. You can use it as you want. If you understand it works you would be able to scale it. With this you will master firebase backend and flutter frontend ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      color: onSurfaceTextColor,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                AppCircleButton(
                  onTap: () => {
                    BlocProvider.of<NavigatorBloc>(context).add(
                        const PushReplacementNamed(route: Routes.HomeRoute))
                  },
                  width: 14,
                  child: const Icon(
                    Icons.arrow_forward,
                    // color: Colors.amber,
                    size: 35,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
