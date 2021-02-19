import 'package:my_app/services/authentication.dart';
import 'package:stacked/stacked.dart';

import 'package:my_app/services_locator.dart';
import 'package:my_app/services/authentication.dart';

/// SignInViewModel
class SignInViewModel extends BaseViewModel {
  final _auth = servicesLocator<AuthService>();

  void login() async {
    await _auth.lineLogin();
  }
}
