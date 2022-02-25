import 'dart:convert';

class OrderProductDetail {
  final String name;
  final String url;
  final double price;
  final int quantity;

  OrderProductDetail({
    required this.name,
    required this.url,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
      'price': price,
      'quantity': quantity,
    };
  }

  factory OrderProductDetail.fromMap(Map<String, dynamic> map) {
    return OrderProductDetail(
      name: map['name'] ?? '',
      url: map['url'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  // factory OrderProductDetail.fromJson(String source) => OrderProductDetail.fromMap(json.decode(source));
}
