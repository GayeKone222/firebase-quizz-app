part of 'questions_bloc.dart';

enum QuestionsStatus { success, loading, failure }

class QuestionsState extends Equatable {
  final QuestionsStatus status;
  final List<QuestionsModel>? allQuestions;

  const QuestionsState(
      {this.status = QuestionsStatus.loading, this.allQuestions});

  QuestionsState copyWith(
      {QuestionsStatus? status, List<QuestionsModel>? allQuestions}) {
    return QuestionsState(
        status: status ?? this.status,
        allQuestions: allQuestions ?? this.allQuestions);
  }

  @override
  List<Object?> get props => [status, allQuestions];
}
