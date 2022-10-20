part of 'db_firebase_upload_bloc.dart';

@immutable
abstract class DbFirebaseUploadEvent extends Equatable {
  const DbFirebaseUploadEvent();

  @override
  List<Object?> get props => [];
}

class UploadDB extends DbFirebaseUploadEvent {}

class SaveTestResult extends DbFirebaseUploadEvent {
  final AuthenticationDetailModel user;
  final QuestionPapersModel questionPapers;

  const SaveTestResult({required this.user, required this.questionPapers});

   @override
  List<Object?> get props => [user, questionPapers];
}
