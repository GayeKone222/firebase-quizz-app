import 'package:firebase_study_app/core/configs/themes/app_colors.dart';
import 'package:firebase_study_app/features/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(gradient: mainGradient(context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/app_splash_logo.png",
                height: 200,
                width: 200,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 60, 16, 60),
                child: Text(
                  "This is a study app, You can use it as you want. You have the full access",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: onSurfaceTextColor, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton.icon(
                  style: TextButton.styleFrom(
                      backgroundColor: onSurfaceTextColor, elevation: 5),
                  onPressed: () => BlocProvider.of<AuthenticationBloc>(context)
                      .add(AuthenticateWithGoogleSignIn()),
                  icon: SvgPicture.asset("assets/icons/google.svg"),
                  label: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Sign in with Google",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ))
            ],
          )),
    );
  }
}
