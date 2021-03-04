import 'package:my_app/model/user.dart';
import 'package:my_app/model/friend.dart';
import 'package:my_app/model/category.dart';
import 'package:my_app/model/wish.dart';
import 'package:my_app/model/friend_wish.dart';

/// data from anywhere
class DataService {
  String access_token = "";
  String get accessToken => access_token;

  User Me = new User();
  List<Friend> MyFriends = [new Friend()];
  List<Category> Categories = [];
  Map<String, List<Wish>> Wishes = {};
  Map<String, List<FriendWish>> FriendWishes = {};

  User get getMe => Me;
  List<Friend> get getMyFriends => MyFriends;
  List<Category> get getCategories => Categories;
  Map<String, List<Wish>> get getWishes => Wishes;
  Map<String, List<FriendWish>> get getFriendWishes => FriendWishes;

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

  Future saveWishes(Map<String, List<Wish>> wishes) async {
    Wishes = wishes;
  }

  Future saveFriendWishes(Map<String, List<FriendWish>> wishes) async {
    FriendWishes = wishes;
  }
}
