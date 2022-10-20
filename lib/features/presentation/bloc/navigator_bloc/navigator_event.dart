part of 'navigator_bloc.dart';

abstract class NavigatorEvent extends Equatable {
  const NavigatorEvent();

  @override
  List<Object?> get props => [];
}

// this is the event that's triggered when the user
// wants to change pages
class PushNamed<T> extends NavigatorEvent {
  final String route;
  final Map<String, String>? queryParams;
  final T? objectParam;
  const PushNamed({required this.route, this.queryParams, this.objectParam});
  @override
  List<Object?> get props => [route, queryParams, objectParam];

  @override
  String toString() => 'PushNamed to $route with';
}

class PushNamedAndRemoveUntil<T> extends NavigatorEvent {
  final String route;
  final String? untilRoute;
  final Map<String, String>? queryParams;
  final T? objectParam;
  const PushNamedAndRemoveUntil(
      {required this.route,
      this.untilRoute,
      this.queryParams,
      this.objectParam});
  @override
  List<Object?> get props => [route, queryParams, untilRoute, objectParam];

  @override
  String toString() => 'PushNamedAndRemoveUntil to $route with';
}

class PushReplacementNamed<T> extends NavigatorEvent {
  final String route;
  final Map<String, String>? queryParams;
  final T? objectParam;
  const PushReplacementNamed(
      {required this.route, this.queryParams, this.objectParam});
  @override
  List<Object?> get props => [route, queryParams, objectParam];

  @override
  String toString() => 'PushReplacementNamed to $route with';
}

class Pop extends NavigatorEvent {}

class PopAll extends NavigatorEvent {}
