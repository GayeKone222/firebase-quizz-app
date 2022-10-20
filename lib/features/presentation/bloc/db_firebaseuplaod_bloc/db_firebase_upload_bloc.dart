import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_study_app/features/data/Repositories/firebase_database_repository.dart';
import 'package:firebase_study_app/features/domain/models/auth_details_model.dart';
import 'package:firebase_study_app/features/domain/models/question_papers.dart';
import 'package:meta/meta.dart';

part 'db_firebase_upload_event.dart';
part 'db_firebase_upload_state.dart';

class DbFirebaseUploadBloc
    extends Bloc<DbFirebaseUploadEvent, DbFirebaseUploadState> {
  final RepositoryFireStoreDatabase repository;
  DbFirebaseUploadBloc({required this.repository})
      : super(const DbFirebaseUploadState()) {
    on<UploadDB>(_onUploadDB);
    on<SaveTestResult>(_onSaveTestResult);
  }

  void _onUploadDB(UploadDB event, Emitter<DbFirebaseUploadState> emit) async {
    emit(state.copyWith(status: DbFirebaseUploadStatus.loading));

    bool result = await repository.onUploadDB();

    if (result) {
      emit(state.copyWith(status: DbFirebaseUploadStatus.success));
    } else {
      emit(state.copyWith(status: DbFirebaseUploadStatus.failure));
    }
  }

  void _onSaveTestResult(
      SaveTestResult event, Emitter<DbFirebaseUploadState> emit) async {
    emit(state.copyWith(status: DbFirebaseUploadStatus.loading));
    try {
      await repository.saveTestResults(
          user: event.user, questionPapers: event.questionPapers);

      emit(state.copyWith(status: DbFirebaseUploadStatus.success));
    } catch (e) {
      emit(state.copyWith(status: DbFirebaseUploadStatus.failure));
    }
  }
}
