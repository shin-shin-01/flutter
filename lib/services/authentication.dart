import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:my_app/services/data.dart';

import 'package:my_app/services_locator.dart';
import 'package:my_app/services/navigation.dart';
import 'package:my_app/model/user.dart';

class AuthService {
  final _navigation = servicesLocator<NavigationService>();
  final _data = servicesLocator<DataService>();

  Future lineLogin() async {
    try {
      final result = await LineSDK.instance.login();
      User user = new User(
          id: 1,
          name: result.userProfile.displayName,
          uid: result.userProfile.userId,
          account_id: 'dummy',
          picture_url: result.userProfile.pictureUrl);

      /// ユーザデータの保存
      await _data.saveUser(user, result.accessToken.value);
      _navigation.pushAndReplace(routeName: '/root');
    } on PlatformException catch (e) {
      // Error handling.
      print(e);
    }
  }
}
