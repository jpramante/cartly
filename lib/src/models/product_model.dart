class Product {
  late String name;
  late String category;
  late String description;
  late String thumbnail;
  late String id;
  late String price;
  late String promo;
  late bool favorite = false;
  bool onPromo = false;

  Product(
      {required this.id,
      required this.name,
      required this.category,
      required this.description,
      required this.thumbnail,
      required this.price,
      required this.promo,
      required this.favorite});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    description = json['description'];
    favorite = json['favorite'];
    price = json['price'];
    promo = json['promo'];
    thumbnail = json['thumbnail'];
  }
}
