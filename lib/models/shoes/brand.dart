import 'package:cloud_firestore/cloud_firestore.dart';

class Brand {
  final int id;
  final String brand;
  final String imagePath;
  final Timestamp createdAt;

  Brand({
    required this.id,
    required this.brand,
    required this.imagePath,
    required this.createdAt,
  });
  factory Brand.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Brand(
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
