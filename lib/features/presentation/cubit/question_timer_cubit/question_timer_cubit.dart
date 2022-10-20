import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionTimerCubit extends Cubit<String> {
  QuestionTimerCubit() : super("00:00");

  @override
  Future<void> close() {
    return super.close();
  }

  Timer? timer;

  closeTimer() {
    if (timer?.isActive ?? false) {
      timer!.cancel();
      emit("00:00");
    }
  }

  startTimer({required int timeSeconds}) {
    const duration = Duration(seconds: 1);
    int remainingSeconds = timeSeconds;
    //timer?.cancel();
    timer = Timer.periodic(duration, (timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
        emit("00:00");
      } else {
        int minutes = remainingSeconds ~/ 60;
        int seconds = remainingSeconds % 60;

        remainingSeconds--;
        emit(
            "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}");
      }
    });
  }
}
