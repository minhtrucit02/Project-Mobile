import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shose_store/models/shoes/imageDetail.dart';
import 'package:shose_store/models/shoes/productSize.dart';

class Product {
  Product({
    required this.id,
    required this.brandId,
    required this.name,
    required this.price,
    required this.imageDetail,
    required this.productSize,
    required this.description,
    required this.createAt,
  });
  final int id;
  final int brandId;
  final String name;
  final double price;
  final List<ImageDetail> imageDetail;
  final List<ProductSize> productSize;
  final String description;
  final Timestamp createAt;

  factory Product.fromRealtime(Map<String, dynamic> data) {
    return Product(
      id: data['id'],
      brandId: data['brandId'],
      name: data['name'],
      price: (data['price'] as num).toDouble(),
      description: data['description'],
      createAt: Timestamp.now(),
      imageDetail: (data['listImageProduct'] as List<dynamic>?)
          ?.map((e) => ImageDetail.fromJson(e))
          .toList() ?? [],
      productSize: (data['listProductSize'] as List<dynamic>?)
          ?.map((e) => ProductSize.fromJson(e))
          .toList() ?? [],
    );
  }


  Map<String, dynamic> toJson() => {
    'id': id,
    'brandId': brandId,
    'name': name,
    'price': price,
    'description': description,
    'createAt': createAt,
    'listImageProduct': imageDetail.map((e) => e.toJson()).toList(),
    'listProductSize': productSize.map((e) => e.toJson()).toList(),
  };
}
