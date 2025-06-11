import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  final String userId;
  final int productId;
  final int quantity;
  final double totalPrice;
  final bool status;
  final DateTime createAt;
  final int size;

  CartItem({
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.totalPrice,
    required this.status,
    required this.createAt,
    required this.size,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'productId': productId,
      'quantity': quantity,
      'totalPrice': totalPrice,
      'status': status,
      'createAt': createAt.millisecondsSinceEpoch,
      'size': size,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      userId: json['userId'] as String,
      productId: json['productId'] as int,
      quantity: json['quantity'] as int,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      status: json['status'] as bool,
      createAt: DateTime.fromMillisecondsSinceEpoch(json['createAt'] as int),
      size: json['size'] as int,
    );
  }

  CartItem copyWith({
    String? userId,
    int? productId,
    int? quantity,
    double? totalPrice,
    bool? status,
    DateTime? createAt,
    int? size,
  }) {
    return CartItem(
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      createAt: createAt ?? this.createAt,
      size: size ?? this.size,
    );
  }
}
