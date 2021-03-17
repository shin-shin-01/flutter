class FriendWish {
  /// id
  final int id;

  // ユーザ名
  final String userName;

  // ユーザ画像
  final String userPictureUrl;

  // カテゴリー名
  final String categoryName;

  /// 名称
  final String name;

  /// 欲しい度
  final int star;

  // 欲しいものの画像
  final String imageUrl;

  /// Constructor
  FriendWish(
      {this.id,
      this.userName,
      this.userPictureUrl,
      this.categoryName,
      this.name,
      this.star,
      this.imageUrl});

  factory FriendWish.fromJson(Map<String, dynamic> json) {
    return FriendWish(
        id: json['id'] as int,
        userName: json['user_name'] as String,
        userPictureUrl: json['user_picture_url'] as String,
        categoryName: json['category_name'] as String,
        name: json['name'] as String,
        star: json['star'] as int,
        imageUrl: json['image_url'] as String);
  }
}
