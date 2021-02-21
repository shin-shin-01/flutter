import 'dart:convert';

class User {
  /// id
  final int id;

  /// 名前
  final String name;

  /// userId
  final String uid;

  /// Constructor
  User({this.id, this.name, this.uid});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'] as int,
        name: json['name'] as String,
        uid: json['uid'] as String);
  }
}
