import 'dart:convert';

class Friend {
  /// id
  final int id;

  /// 名前
  final String name;

  /// pictureUrl
  final String picture_url;

  /// Constructor
  Friend({this.id, this.name, this.picture_url});

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      id: json['id'] as int,
      name: json['name'] as String,
      picture_url: json['picture_url'] as String,
    );
  }
}
