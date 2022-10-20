import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_study_app/features/data/Repositories/firebase_database_repository.dart';
import 'package:firebase_study_app/features/domain/models/question_papers.dart';
import 'package:firebase_study_app/features/domain/models/questions.dart';

part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  final RepositoryFireStoreDatabase repository;
  QuestionsBloc({required this.repository}) : super(const QuestionsState()) {
    on<GetAllQuestions>(_onGetAllQuestions);
      on<ReInitialise>(_onReInitialise);
  }

  void _onReInitialise( ReInitialise event, Emitter<QuestionsState> emit){
    emit(const QuestionsState());
  }

  void _onGetAllQuestions(
      GetAllQuestions event, Emitter<QuestionsState> emit) async {
    emit(state.copyWith(status: QuestionsStatus.loading));

    List<QuestionsModel>? result = await repository.getAllQuestions(
        questionPapersModel: event.questionPapersModel);

    if (result != null) {
      emit(state.copyWith(
          status: QuestionsStatus.success, allQuestions: result));
    } else {
      emit(state.copyWith(status: QuestionsStatus.failure));
    }
  }
}
