class Product {
  final String? productId;
  final String name;
  final String productCode;
  final num price;
  final int quantity;
  final String? description;

  Product({
    this.description,
    this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.productCode,
  });

  Product copyWith({
    String? description,
    String? name,
    int? price,
    int? quantity,
    String? productId,
    String? productCode,
  }) =>
      Product(
        description: description ?? this.description,
        name: name ?? this.name,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        productId: productId ?? this.productId,
        productCode: productCode ?? this.productCode,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        description: json["description"],
        name: json["name"],
        price: json["price"],
        quantity: json["quantity"],
        productId: json["productId"],
        productCode: json["productCode"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "name": name,
        "price": price,
        "quantity": quantity,
        "productId": productId,
        "productCode": productCode,
      };
}
