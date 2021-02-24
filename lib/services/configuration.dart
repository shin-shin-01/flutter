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

  static String colorTheme = "beige";

  static Map<String, Map<String, int>> colors = {
    "beige": {
      "primaryColor": 0xffEEE8E1,

      /// 選択: 濃い色
      "secondColor": 0xff9E837B,

      /// 濃いベージュ
      "naviBackgroundColor": 0xffD3C3BF,
      "bottomNaviBackgroundColor": 0xffD3C3BF,

      /// ライトベージュ
      "listColor": 0xffEEE8E1,
      "formColor": 0xffEEE8E1,
      "buttonBackground": 0xffEEE8E1,

      "formBorderColor": 0xff9E837B,

      /// 薄い灰色
      "backgroundColor": 0xffF2EEEC,

      /// 灰色
      "font": 0xff8A8A8A,
    },
    "dark": {}
  };

  final app_color = {
    "text": Color(colors[colorTheme]["font"]),

    /// appBar
    "appBarBackground": Color(colors[colorTheme]["naviBackgroundColor"]),
    "appBarIconBackground": Colors.transparent,

    /// appBottom
    "bottomBackground": Color(colors[colorTheme]["bottomNaviBackgroundColor"]),

    /// sideMenu
    "sideMenuHeader":
        Color(colors[colorTheme]["naviBackgroundColor"]).withOpacity(0.9),

    /// progressBar
    "progressBar": Color(colors[colorTheme]["secondColor"]).withAlpha(150),
    "progressBarBackground":
        Color(colors[colorTheme]["primaryColor"]).withAlpha(150),
    "progressBarBorder": Color(colors[colorTheme]["secondColor"]),

    /// successScreen
    "successButtonBackground": Color(colors[colorTheme]["buttonBackground"]),
    "successBackground": Color(colors[colorTheme]["backgroundColor"]),

    /// waitingForScreen
    "waitingBackground": Color(colors[colorTheme]["backgroundColor"]),

    /// Loading
    "loadingBackground": Color(colors[colorTheme]["primaryColor"]),
    "loadingIcon": Colors.white,

    /// Category appBar
    "categoryAppBarBackground":
        Color(colors[colorTheme]["naviBackgroundColor"]),
    "categoryAppBarTabIndicator": Color(colors[colorTheme]["secondColor"]),
    "categoryAppBarTabLabel": Color(colors[colorTheme]["secondColor"]),
    "categoryAppBarTabUnselectedLabel": Colors.grey,

    /// Category body
    "categoryBodyBackground": Color(colors[colorTheme]["backgroundColor"]),

    /// wishTile
    "wishTileBackground": Color(colors[colorTheme]["listColor"]),
    "wishTileFont": Color(colors[colorTheme]["font"]),

    /// dialog
    "dialogBackground": Color(colors[colorTheme]["backgroundColor"]),
    "dialogBorder": Color(colors[colorTheme]["font"]),

    /// CreateWish
    "createWishSubmitBackground": Color(colors[colorTheme]["buttonBackground"]),
    "createWishAppBarBackgound":
        Color(colors[colorTheme]["naviBackgroundColor"]),
    "createWishBodyBackground": Color(colors[colorTheme]["backgroundColor"]),
    "createWishFormBackground": Color(colors[colorTheme]["formColor"]),
    "createFormBorderColor": Color(colors[colorTheme]["formBorderColor"]),
    "createWishFont": Color(colors[colorTheme]["font"]),
  };

  Map get appColor => app_color;
}
