import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shimmer/shimmer.dart';

class QuestionsShimmer extends StatelessWidget {
  const QuestionsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var line = Container(
      width: double.infinity,
      height: 12.0,
      color: Theme.of(context).scaffoldBackgroundColor,
    );

    var answer = Container(
      width: double.infinity,
      height: 50.0,
      color: Theme.of(context).scaffoldBackgroundColor,
    );

    return Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.blueGrey.withOpacity(0.5),
        child: EasySeparatedColumn(
            children: [
              EasySeparatedColumn(
                  children: [line, line, line, line],
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 20,
                    );
                  }),
              answer,
              answer,
              answer,
            ],
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 20,
              );
            }));
  }
}
