class Deal {
  final String? description;
  final String name;
  final String imageUrl;
  final String shop;
  final dynamic dealPrice;
  final dynamic regularPrice;
  final dynamic basePrice;

  Deal(
      {required this.name,
      required this.shop,
      required this.imageUrl,
      required this.dealPrice,
      this.description,
      this.basePrice,
      this.regularPrice});

  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      shop: json['shop'] as String,
      dealPrice: json['dealPrice'],
      regularPrice: json['regularPrice'],
      basePrice: json['basePrice'],
    );
  }
}
