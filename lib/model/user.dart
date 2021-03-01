import 'dart:convert';

class User {
  /// id
  final int id;

  /// 名前
  final String name;

  /// userId
  final String uid;

  /// accountId
  final String account_id;

  /// pictureUrl
  final String picture_url;

  /// Constructor
  User({this.id, this.name, this.uid, this.account_id, this.picture_url});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      uid: json['uid'] as String,
      account_id: json['account_id'] as String,
      picture_url: json['picture_url'] as String,
    );
  }
}
