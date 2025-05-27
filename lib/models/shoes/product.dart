import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  Product({
    required this.id,
    required this.brand,
    required this.imagePath,
    required this.createdAt,
  });
  final int id;
  final String brand;
  final String imagePath;
  final Timestamp createdAt;

  //TODO: add json converts

  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Product(
      id: data['id'] ?? 0,
      brand: data['brand'] ?? '',
      imagePath: data['imagePath'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'brand': brand,
    'imagePath': imagePath,
    'createdAt': createdAt,
  };
}
