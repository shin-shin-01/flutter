class Wish {
  /// id
  final int id;

  // ユーザ名
  final String userName;

  // カテゴリー名
  final String categoryName;

  /// 名称
  final String name;

  /// 欲しい度
  final int star;

  // 欲しいものの画像
  String imageUrl;

  /// Constructor
  Wish(
      {this.id,
      this.userName,
      this.categoryName,
      this.name,
      this.star,
      this.imageUrl});

  factory Wish.fromJson(Map<String, dynamic> json) {
    return Wish(
        id: json['id'] as int,
        userName: json['user_name'] as String,
        categoryName: json['category_name'] as String,
        name: json['name'] as String,
        star: json['star'] as int,
        imageUrl: json['image_url'] as String);
  }
}
