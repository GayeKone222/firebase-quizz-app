part of 'firebase_storage_bloc.dart';

abstract class FirebaseStorageEvent extends Equatable {
  const FirebaseStorageEvent();

  @override
  List<Object> get props => [];
}

class GetAllPapersImages extends FirebaseStorageEvent {}
