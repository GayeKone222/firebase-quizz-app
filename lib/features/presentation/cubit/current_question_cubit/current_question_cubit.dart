import 'package:firebase_study_app/features/domain/models/questions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentQuestionCubit extends Cubit<QuestionsModel?> {
  CurrentQuestionCubit() : super(null);

  setQuestion(QuestionsModel? questionsModel) {
    emit(questionsModel);
  }

  nextQuestion(
      {required QuestionsModel currentQuestion,
      required List<QuestionsModel> allQuestions}) {
    QuestionsModel nextQuestion =
        allQuestions.elementAt(allQuestions.indexOf(currentQuestion) + 1);

    emit(nextQuestion);
  }

  previousQuestion(
      {required QuestionsModel currentQuestion,
      required List<QuestionsModel> allQuestions}) {
    QuestionsModel previousQuestion =
        allQuestions.elementAt(allQuestions.indexOf(currentQuestion) - 1);

    emit(previousQuestion);
  }
}
