import 'package:flutter/material.dart';

class Category {
  /// id
  final int id;

  /// 名前
  final String name;

  /// Constructor
  Category({this.id, this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}
