part of 'questions_bloc.dart';

abstract class QuestionsEvent extends Equatable {
  const QuestionsEvent();

  @override
  List<Object> get props => [];
}

class ReInitialise extends QuestionsEvent {}

class GetAllQuestions extends QuestionsEvent {
  final QuestionPapersModel questionPapersModel;

 const GetAllQuestions({required this.questionPapersModel});

   @override
  List<Object> get props => [questionPapersModel];
}
