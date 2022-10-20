part of 'firebase_storage_bloc.dart';

enum FirebaseStorageStatus {  success, loading, failure }

class FirebaseStorageState extends Equatable {
  final FirebaseStorageStatus status;
  final List<QuestionPapersModel>? allPaperImages;

  const FirebaseStorageState(
      {this.status = FirebaseStorageStatus.loading, this.allPaperImages});

  FirebaseStorageState copyWith(
      {FirebaseStorageStatus? status, List<QuestionPapersModel>? allPaperImages}) {
    return FirebaseStorageState(
        status: status ?? this.status,
        allPaperImages: allPaperImages ?? this.allPaperImages);
  }

  @override
  List<Object?> get props => [status, allPaperImages];
}
