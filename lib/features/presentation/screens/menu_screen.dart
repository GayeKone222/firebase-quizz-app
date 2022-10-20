import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_study_app/core/configs/themes/app_colors.dart';
import 'package:firebase_study_app/core/configs/themes/ui_parameters.dart';
import 'package:firebase_study_app/features/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:transparent_image/transparent_image.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: UIParameters.mobileScreenpadding.copyWith(right: 0),
      width: double.maxFinite,
      // decoration: BoxDecoration(gradient: mainGradient(context)),
      child: Theme(
          data: ThemeData(
              textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(primary: onSurfaceTextColor))),
          child: SafeArea(
              child: Stack(
            children: [
              Positioned(
                  top: 0,
                  right: 0,
                  child: BackButton(
                    color: Colors.white,
                    onPressed: () => ZoomDrawer.of(context)!.toggle(),
                  )),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  return state.status == AuthenticationStatus.authenticated
                      ? Column(
                          children: [
                            CachedNetworkImage(
                              imageUrl: state.user!.photoUrl!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  Image.memory(kTransparentImage),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              state.user!.name!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: onSurfaceTextColor),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DrawerButton(
                                  icon: Icons.web,
                                  onPressed: () {},
                                  label: "website",
                                ),
                                DrawerButton(
                                  icon: Icons.facebook,
                                  onPressed: () {},
                                  label: "facebook",
                                ),
                                DrawerButton(
                                  icon: Icons.email,
                                  onPressed: () {},
                                  label: "email",
                                ),
                              ],
                            ),
                            const Spacer(),
                            DrawerButton(
                              icon: Icons.logout,
                              onPressed: () {
                                context
                                    .read<AuthenticationBloc>()
                                    .add(LogOut());
                              },
                              label: "logout",
                            )
                          ],
                        )
                      : const SizedBox();
                },
              )
            ],
          ))),
    );
  }
}

class DrawerButton extends StatelessWidget {
  const DrawerButton(
      {Key? key,
      required this.icon,
      required this.label,
      required this.onPressed})
      : super(key: key);

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 15,
        ),
        label: Text(label));
  }
}
