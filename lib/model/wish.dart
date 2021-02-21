class Wish {
  /// id
  final int id;

  /// 名称
  final String name;

  /// 欲しい度
  final int star;

  /// Constructor
  Wish({this.id, this.name, this.star});

  factory Wish.fromJson(Map<String, dynamic> json) {
    return Wish(
        id: json['id'] as int,
        name: json['name'] as String,
        star: json['star'] as int);
  }
}
