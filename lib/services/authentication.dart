import 'package:flutter/services.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';

import 'package:my_app/services_locator.dart';
import 'package:my_app/services/navigation.dart';

class AuthService {
  final _navigation = servicesLocator<NavigationService>();

  String access_token = "";
  String get accessToken => access_token;

  Future lineLogin() async {
    try {
      final result = await LineSDK.instance.login();
      // user name -> result.userProfile.displayName
      // user avatar -> result.userProfile.pictureUrl
      // etc...
      access_token = result.accessToken.value;
      _navigation.pushAndReplace(routeName: '/root');
    } on PlatformException catch (e) {
      // Error handling.
      print(e);
    }
  }
}
