import 'package:flutter/services.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';

import 'package:my_app/services_locator.dart';
import 'package:my_app/services/navigation.dart';

class AuthService {
  final _navigation = servicesLocator<NavigationService>();

  String access_token = "";
  String get accessToken => access_token;
  String display_name = "";
  String get name => display_name;
  String user_id = "";
  String get uid => user_id;
  String pictur_url = "";
  String get picturUrl => pictur_url;

  Future lineLogin() async {
    try {
      final result = await LineSDK.instance.login();
      // user name -> result.userProfile.displayName
      // user avatar -> result.userProfile.pictureUrl
      // etc...
      access_token = result.accessToken.value;
      display_name = result.userProfile.displayName;
      user_id = result.userProfile.userId;
      pictur_url = result.userProfile.pictureUrl;

      _navigation.pushAndReplace(routeName: '/root');
    } on PlatformException catch (e) {
      // Error handling.
      print(e);
    }
  }
}
