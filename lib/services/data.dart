import 'package:flutter/services.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:my_app/model/user.dart';
import 'package:my_app/model/friend.dart';
import 'package:my_app/model/category.dart';

/// data from anywhere
class DataService {
  String access_token = "";
  String get accessToken => access_token;

  User Me = new User();
  List<Friend> MyFriends = [new Friend()];
  List<Category> Categories = [];

  User get getMe => Me;
  List<Friend> get getMyFriends => MyFriends;
  List<Category> get getCategories => Categories;

  Future saveUser(User user, [String accessToken]) async {
    Me = user;
    if (accessToken != null) {
      access_token = accessToken;
    }
  }

  Future saveFriends(List<Friend> friends) async {
    MyFriends = friends;
  }

  Future saveCategories(List<Category> categories) async {
    Categories = categories;
  }
}
