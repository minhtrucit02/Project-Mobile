import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductSize {
  ProductSize({
    required this.id,
    required this.productDetailId,
    required this.size,
    required this.quantity,
});
  final int id;
  final int productDetailId;
  final String size;
  final int quantity;

  factory ProductSize.fromJson(Map<String, dynamic> json) => ProductSize(
      id: json['id'],
      productDetailId: json['productDetailId'],
      size: json['size'],
      quantity: json['quantity']
  );

  Map<String, dynamic> toJson() => {
    'id':id,
    'productDetailId':productDetailId,
    'size': size,
    'quantity':quantity,
  };

}