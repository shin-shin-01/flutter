import 'package:flutter/material.dart';

class ConfigurationService {
  /// apiRootUrl
  String get apiRootUrl {
    return 'https://wishapp-api.herokuapp.com';
    // return 'http://localhost:3000';
  }

  /// apiVersion
  int get apiVersion => 1;
  String get authorizationHeaderName {
    return 'LINEAuthorization';
  }

  static int primaryColor = 0xff3f3f3f;

  final app_color = {
    "primaryColor": Color(primaryColor),
    "text": Color(primaryColor),

    /// appBar
    "appBarBackground": Colors.grey.withOpacity(0.9),
    "appBarIconBackground": Colors.transparent,

    /// sideMenu
    "sideMenuHeader": Colors.grey.withOpacity(0.9),

    /// progressBar
    "progressBar": Color(primaryColor).withAlpha(150),
    "progressBarBackground": Colors.white,
    "progressBarBorder": Color(primaryColor),

    /// successScreen
    "successButtonBackground": Colors.white,

    /// Loading
    "loadingBackground": Color(primaryColor).withAlpha(150),
    "loadingIcon": Colors.white,

    /// Category
    "categoryAppBarBackground": Colors.white,
    "categoryAppBarTabIndicator": Colors.green,
    "categoryAppBarTabLabel": Colors.green,
    "categoryAppBarTabUnselectedLabel": Colors.grey,

    /// dialog
    "dialogBackground": Colors.white,
    "dialogBorder": Colors.grey,

    /// CreateWish
    "createWishSubmitBackground": Colors.blue.withOpacity(0.2),
    "createWishBackgound": Colors.white,

    /// Root
    "rootBackground": Color(0xffdfefff),
  };

  Map get appColor => app_color;
}
