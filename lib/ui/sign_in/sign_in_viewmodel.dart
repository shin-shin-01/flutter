import 'package:my_app/services/authentication.dart';
import 'package:stacked/stacked.dart';

import 'package:my_app/services_locator.dart';
import 'package:my_app/services/authentication.dart';
import 'package:my_app/services/navigation.dart';
import 'package:my_app/services/api.dart';

/// SignInViewModel
class SignInViewModel extends BaseViewModel {
  final _auth = servicesLocator<AuthService>();
  final _navigation = servicesLocator<NavigationService>();
  final _api = servicesLocator<APIService>();

  void login() async {
    setBusy(true);
    await _auth.lineLogin();
    print("done: lineLogin");
    await _api.createUser();
    print("done: createUser");
    await _api.getFriends();
    print("done: getFriends");
    await _api.getCategories();
    print("done: getCategories");

    _navigation.pushAndReplace(routeName: '/root');
  }
}
