import "dart:async";

import 'package:my_app/services_locator.dart';
import 'package:my_app/services/navigation.dart';

/// StartupService
/// SplashView で使用
class StartupService {
  final _navigation = servicesLocator<NavigationService>();

  /// handleStartUpLogic
  /// - navigate to respective route based on different coniditions
  Future handleStartUpLogicFake() async {
    await new Future.delayed(new Duration(seconds: 3));
    _navigation.pushNamedAndRemoveUntil(routeName: '/sign_in');
  }
}
