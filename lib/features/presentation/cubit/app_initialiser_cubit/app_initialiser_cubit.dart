 
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_initialiser_state.dart';

class AppInitialiserCubit extends Cubit<AppInitialiserState> {
  AppInitialiserCubit() : super(AppInitialiserInitial());

    void initApp( ) async {

     await Future.delayed(const Duration(seconds: 2));

     emit(AppInitialiserInitialed());

    }


}
