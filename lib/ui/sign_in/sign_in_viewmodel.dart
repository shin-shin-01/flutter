import 'package:stacked/stacked.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';

import 'package:my_app/services_locator.dart';
import 'package:my_app/services/navigation.dart';

/// SignInViewModel
class SignInViewModel extends BaseViewModel {
  final _navigation = servicesLocator<NavigationService>();

  void lineLogin() async {
    try {
      final result = await LineSDK.instance.login();
      // user id -> result.userProfile.userId
      // user name -> result.userProfile.displayName
      // user avatar -> result.userProfile.pictureUrl
      // etc...
      _navigation.pushAndReplace(routeName: '/root');
    } on PlatformException catch (e) {
      // Error handling.
      print(e);
    }
  }
}
