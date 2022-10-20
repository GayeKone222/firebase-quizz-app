part of 'app_initialiser_cubit.dart';

abstract class AppInitialiserState extends Equatable {
  const AppInitialiserState();

  @override
  List<Object> get props => [];
}

class AppInitialiserInitial extends AppInitialiserState {}

class AppInitialiserInitialed extends AppInitialiserState {}
