part of 'db_firebase_upload_bloc.dart';

enum DbFirebaseUploadStatus { initial, success, loading, failure }

class DbFirebaseUploadState extends Equatable {
  final DbFirebaseUploadStatus status;

  const DbFirebaseUploadState({
    this.status = DbFirebaseUploadStatus.initial,
  });

  DbFirebaseUploadState copyWith({
    DbFirebaseUploadStatus? status,
  }) {
    return DbFirebaseUploadState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}
