import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    if (kDebugMode) {
      debugPrint(
          '\x1b[33m [Bloc] Event -- ${bloc.runtimeType}, event: $event \x1B[0m');
    }
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    if (kDebugMode) {
      debugPrint(
          '\x1b[33m [Bloc] Transition --${bloc.runtimeType}, transition: $transition \x1B[0m');
    }
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      debugPrint(
        '\x1b[31m [Bloc] Error -- cubit: ${bloc.runtimeType}, error: $error, $stackTrace',
      );
    }
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    if (kDebugMode) {
      debugPrint(
          '\x1b[33m [Bloc] onChange --${bloc.runtimeType}, change: ${change.currentState} => ${change.nextState} \x1B[0m');
    }
    super.onChange(bloc, change);
  }

  @override
  void onCreate(BlocBase bloc) {
    if (kDebugMode) {
      debugPrint('\x1b[33m [Bloc] onCreate --${bloc.runtimeType}\x1B[0m');
    }
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase bloc) {
    if (kDebugMode) {
      debugPrint('\x1b[33m [Bloc] onClose --${bloc.runtimeType}\x1B[0m');
    }
    super.onClose(bloc);
  }
}
