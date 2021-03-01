import 'package:my_app/services/authentication.dart';
import 'package:stacked/stacked.dart';

import 'package:my_app/services_locator.dart';
import 'package:my_app/services/authentication.dart';
import 'package:my_app/services/api.dart';

/// SignInViewModel
class SignInViewModel extends BaseViewModel {
  final _auth = servicesLocator<AuthService>();
  final _api = servicesLocator<APIService>();

  void login() async {
    await _auth.lineLogin();

    /// TODO: User情報どこかにセットする必要あるかも
    await _api.createUser();
    await _api.getFriends();
  }
}
