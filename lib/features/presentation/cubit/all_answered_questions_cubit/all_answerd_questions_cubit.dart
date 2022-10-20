import 'dart:async';

import 'package:firebase_study_app/features/domain/models/answer.dart';
import 'package:firebase_study_app/features/domain/models/questions.dart';
import 'package:firebase_study_app/features/presentation/bloc/questions_bloc/questions_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//in order to listen to another bloc's states :
//https://stackoverflow.com/questions/72085170/flutter-bloc-8-what-is-the-best-practice-for-listening-to-state-changes-from-an
//we should set the lazy value to false in the provider also
//https://stackoverflow.com/questions/72478357/flutter-bloc-stream-listen-not-listening-to-state-change

class AllAnswerdQuestionsCubit
    extends Cubit<Map<QuestionsModel, AnswersModel?>> {
  AllAnswerdQuestionsCubit({required this.questionBloc})
      : super({
          QuestionsModel(
              id: "", answers: const [], correctAnswer: "", question: ""): null
        });

  //       {
  //   // questionsStreamSub = questionBloc.stream.listen((state) {
  //   //   if (state.status == QuestionsStatus.success &&
  //   //       state.allQuestions != null) {
  //   //     print("we are here");
  //   //     emit({for (var e in state.allQuestions!) e: null});
  //   //   }
  //   // });
  // }

  final QuestionsBloc questionBloc;

  StreamSubscription<QuestionsState>? questionsStreamSub;

  @override
  Future<void> close() {
    questionsStreamSub?.cancel();
    return super.close();
  }

  // StreamSubscription<QuestionsState>? subscription;

  // AllAnswerdQuestionsCubit({required this.questions})
  //     : super({for (var e in questions) e: null});
//  final List<QuestionsModel> questions;

// Map<QuestionsModel, AnswersModel> questionsAnswersMap;

  void init() {
    print("here1");
    questionsStreamSub = questionBloc.stream.listen((state) {
      print("here2");
      if (state.status == QuestionsStatus.success &&
          state.allQuestions != null) {
        print("here3");
        emit({for (var e in state.allQuestions!) e: null});
      }
    });
  }

  void reset() {
    emit({for (var e in state.entries) e.key: null});
  }

  void selectAnswer(
      {required QuestionsModel currentQuestion,
      required AnswersModel selectedAnswer}) {
    //delete items with empty obect

    Map<QuestionsModel, AnswersModel?> questionsAnswersMap =
        Map<QuestionsModel, AnswersModel?>.from(state)
          ..removeWhere((key, value) => key.id.isEmpty)
          ..addAll({currentQuestion: selectedAnswer});

    // print("questionsAnswersMap : ${questionsAnswersMap[currentQuestion]}");
    emit(questionsAnswersMap);
  }
}
