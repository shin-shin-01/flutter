import 'package:flutter/services.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:my_app/model/user.dart';

/// data from anywhere
class DataService {
  String access_token = "";
  String get accessToken => access_token;

  User Me = new User();

  User get getMe => Me;
  Future saveUser(User user, [String accessToken]) async {
    Me = user;
    if (accessToken != null) {
      access_token = accessToken;
    }
  }
}
