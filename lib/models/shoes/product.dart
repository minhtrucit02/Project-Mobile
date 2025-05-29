import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  Product({
    required this.id,
    required this.brandId,
    required this.name,
    required this.price,
    required this.description,
    required this.feedback,
    required this.createAt,
});
  final int id;
  final int brandId;
  final String name;
  final double price;
  final String description;
  final String feedback;
  final DateTime createAt;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    brandId: json['brandId'],
    name: json['name'],
    price: json['price'],
    description:json['description'] ,
    feedback: json['feedback'],
    createAt: json['createAt'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'brandId':brandId,
    'name': name,
    'price':price,
    'description':description,
    'feedback':feedback,
    'createAt':createAt,
  };


}