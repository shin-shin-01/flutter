import 'package:flutter/material.dart';

/// NavigationService
class NavigationService {
  // Navigator を指定するキー
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// currentContext
  /// - context を navigatorKey から取得する
  BuildContext get currentContext => navigatorKey.currentContext;

  /// routeName にページ遷移 (push)
  Future<dynamic> pushNamed({@required String routeName, dynamic args}) =>
      navigatorKey.currentState.pushNamed(routeName, arguments: args);

  /// routeName にページ遷移 (route を上書き)
  Future<dynamic> pushAndReplace({String routeName}) =>
      navigatorKey.currentState.pushReplacementNamed(routeName);

  /// routeName にページ遷移 (遷移記録を消去)
  Future<dynamic> pushNamedAndRemoveUntil({String routeName}) =>
      navigatorKey.currentState
          .pushNamedAndRemoveUntil(routeName, (route) => false);

  /// 前のページに遷移
  void pop() => navigatorKey.currentState.pop();
}
