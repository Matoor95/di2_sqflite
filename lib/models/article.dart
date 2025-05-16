class Article {
  int id;
  String name;
  int list;
  String? shop;
  double? price;
  String? image;
  Article(this.id, this.name, this.image, this.list, this.price, this.shop);
  Article.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        list = map['list'],
        shop = map['"shop'],
        image = map["image"],
        price = map["price"];
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'image': image,
      'shop': shop,
      "price": price,
      'list': list
    };
    if (id != null) map['id'] = id;
    return map;
  }
}
