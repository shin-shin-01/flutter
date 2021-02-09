import 'package:stacked/stacked.dart';

import 'package:my_app/services_locator.dart';
import 'package:my_app/services/navigation.dart';

/// SignInViewModel
class SignInViewModel extends BaseViewModel {
  final _navigation = servicesLocator<NavigationService>();

  void submitSignInFake() {
    _navigation.pushAndReplace(routeName: '/home');
  }
}
