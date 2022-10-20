import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_study_app/core/configs/themes/app_colors.dart';
import 'package:firebase_study_app/core/configs/themes/custom_test_styles.dart';
import 'package:firebase_study_app/core/configs/themes/ui_parameters.dart';
import 'package:firebase_study_app/core/utils/app_icons.dart';
import 'package:firebase_study_app/features/domain/models/question_papers.dart';
import 'package:firebase_study_app/features/presentation/bloc/firebase_storage_bloc/firebase_storage_bloc.dart';
import 'package:firebase_study_app/features/presentation/screens/menu_screen.dart';
import 'package:firebase_study_app/features/presentation/widgets/common_widgets/app_circle_button.dart';
import 'package:firebase_study_app/features/presentation/widgets/common_widgets/app_icon_text.dart';
import 'package:firebase_study_app/features/presentation/widgets/common_widgets/content_area.dart';
import 'package:firebase_study_app/features/presentation/widgets/home/question_card.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(gradient: mainGradient(context)),
        child: ZoomDrawer(
          borderRadius: 50,
          // showShadow: true,
          angle: 0.0,
          style: DrawerStyle.defaultStyle,
          // menuBackgroundColor: Colors.transparent,
          // drawerShadowsBackgroundColor: Colors.transparent,
          menuScreenWidth: MediaQuery.of(context).size.width * 0.7,

          slideWidth: MediaQuery.of(context).size.width * 0.6,
          menuScreen: const MenuScreen(),
          mainScreen: BlocBuilder<FirebaseStorageBloc, FirebaseStorageState>(
            builder: (context, state) {
              return Container(
                  decoration: BoxDecoration(gradient: mainGradient(context)),
                  child: state.status == FirebaseStorageStatus.success
                      ? SafeArea(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(mobileScreenPadding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Builder(builder: (context) {
                                      return AppCircleButton(
                                        onTap: () =>
                                            ZoomDrawer.of(context)!.toggle(),
                                        child: const Icon(
                                          AppIcons.menuLeft,
                                        ),
                                      );
                                    }),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: mobileScreenPadding),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            AppIcons.peace,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text("Hello friend",
                                              style: detailText.copyWith(
                                                color: onSurfaceTextColor,
                                              ))
                                        ],
                                      ),
                                    ),
                                    const Text(
                                        "What do you want to learn today",
                                        style: headerText)
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: mobileScreenPadding - 2),
                                  child: ContentArea(
                                    addpadding: false,
                                    child: ListView.separated(
                                        padding:
                                            UIParameters.mobileScreenpadding,
                                        // shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return QuestionCard(
                                            model: state.allPaperImages![index],
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return const SizedBox(
                                            height: 20,
                                          );
                                        },
                                        itemCount:
                                            state.allPaperImages!.length),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Center(
                          child: state.status == FirebaseStorageStatus.failure
                              ? const Text("Imposible de récupérer les images")
                              : const CircularProgressIndicator.adaptive()));
            },
          ),
        ),
      ),
    );
  }
}


// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(title)),
//       body: BlocBuilder<DbFirebaseUploadBloc, DbFirebaseUploadState>(
//         builder: (context, state) {
//           return Center(
//               child: state.status == DbFirebaseUploadStatus.loading
//                   ? const CircularProgressIndicator.adaptive()
//                   : const Text("Data Uploaded"));
//         },
//       ),
//     );
//   }
// }
