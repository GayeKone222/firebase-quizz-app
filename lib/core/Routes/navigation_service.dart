import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

 
  Future<dynamic> navigateTo<T>(String routeName,
      {Map<String, dynamic>? queryParams, T? objectParam}) {
    if (queryParams != null) {
      routeName = Uri(path: routeName, queryParameters: queryParams).toString();
    }

    return navigatorKey.currentState!.pushNamed(routeName, arguments: objectParam);
  }

  Future<dynamic> navigateToAndRemoveUntil<T>(
      String routeName, String untilRouteName,
      {Map<String, String>? queryParams, T? objectParam}) {
    if (queryParams != null) {
      routeName = Uri(path: routeName, queryParameters: queryParams).toString();
    }

    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      ModalRoute.withName(untilRouteName),
      arguments: objectParam
    );
  }

  goBack() {
    return navigatorKey.currentState!.pop();
  }

  Future<dynamic> navigateToAndReplacePrevious<T>(String routeName,
      {Map<String, String>? queryParams, T? objectParam}) {
    if (queryParams != null) {
      routeName = Uri(path: routeName, queryParameters: queryParams).toString();
    }

    return navigatorKey.currentState!.pushReplacementNamed(
      routeName,
       arguments: objectParam
    );
  }

  bool isCurrentRoute(String routeName) {
    bool isCurrent = false;
    navigatorKey.currentState!.popUntil((route) {
      if (route.settings.name == routeName) {
        isCurrent = true;
      }
      return true;
    });
    return isCurrent;
  }
}
