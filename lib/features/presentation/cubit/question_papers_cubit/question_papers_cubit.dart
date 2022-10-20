
import 'package:firebase_study_app/features/domain/models/question_papers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class QuestionPapersCubit extends Cubit<QuestionPapersModel?> {
  QuestionPapersCubit() : super(null);

  setCurrentQuestionPapersModel(
      {required QuestionPapersModel currentQuestionPaper}) {
    emit(currentQuestionPaper);
  }
}
