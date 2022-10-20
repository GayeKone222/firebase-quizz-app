import 'package:equatable/equatable.dart';
import 'package:firebase_study_app/core/Routes/navigation_service.dart';
import 'package:firebase_study_app/core/Routes/routes_name.dart';
import 'package:firebase_study_app/core/dependency_injection.dart/injections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigator_event.dart';
part 'navigator_state.dart';

class NavigatorBloc extends Bloc<NavigatorEvent, NavigatorState> {
  final NavigationService _navigationService = locator<NavigationService>();
  NavigatorBloc() : super(NavigatorInitial()) {
    on<PushNamed>(_onPushNamed);
    on<PushNamedAndRemoveUntil>(_onPushNamedAndRemoveUntil);
    on<PushReplacementNamed>(_onPushReplacementNamed);
    on<Pop>(_onPop);
    on<PopAll>(_onPopAll);
  }

  void _onPushNamed(PushNamed event, Emitter<NavigatorState> emit) async {
    if (!_navigationService.isCurrentRoute(event.route)) {
      emit(NavigatorLoading());
      _navigationService.navigateTo(event.route,
          queryParams: event.queryParams, objectParam: event.objectParam);
      emit(Navigated());
    } else {
      print("route already shown");
    }
  }

  void _onPushNamedAndRemoveUntil(
      PushNamedAndRemoveUntil event, Emitter<NavigatorState> emit) async {
    if (!_navigationService.isCurrentRoute(event.route)) {
      emit(NavigatorLoading());
      _navigationService.navigateToAndRemoveUntil(
          event.route, event.untilRoute!,
          queryParams: event.queryParams, objectParam: event.objectParam);
      emit(Navigated());
    } else {
      print("route already shown");
    }
  }

  void _onPushReplacementNamed(
      PushReplacementNamed event, Emitter<NavigatorState> emit) async {
    if (!_navigationService.isCurrentRoute(event.route)) {
      emit(NavigatorLoading());
      _navigationService.navigateToAndReplacePrevious(event.route,
          queryParams: event.queryParams, objectParam: event.objectParam);
      emit(Navigated());
    } else {
      print("route already shown");
    }
  }

  void _onPop(Pop event, Emitter<NavigatorState> emit) async {
    emit(NavigatorLoading());
    _navigationService.goBack();
    emit(Navigated());
  }

  void _onPopAll(PopAll event, Emitter<NavigatorState> emit) async {
    _navigationService.navigateToAndRemoveUntil(Routes.HomeRoute, "/");
  }
}
