 
import 'package:equatable/equatable.dart';
import 'package:firebase_study_app/features/data/Repositories/firebase_database_repository.dart';
import 'package:firebase_study_app/features/domain/models/question_papers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'firebase_storage_event.dart';
part 'firebase_storage_state.dart';

class FirebaseStorageBloc
    extends Bloc<FirebaseStorageEvent, FirebaseStorageState> {
  final RepositoryFireStoreDatabase repository;
  FirebaseStorageBloc({required this.repository})
      : super(const FirebaseStorageState()) {
    on<GetAllPapersImages>(_onGetAllPapersImages);
  }

  void _onGetAllPapersImages(
      GetAllPapersImages event, Emitter<FirebaseStorageState> emit) async {
    emit(state.copyWith(status: FirebaseStorageStatus.loading));

    List<QuestionPapersModel>? result = await repository.getAllPapers();

    if (result != null) {
      emit(state.copyWith(status: FirebaseStorageStatus.success, allPaperImages: result));
    } else {
      emit(state.copyWith(status: FirebaseStorageStatus.failure));
    }
  }
}
