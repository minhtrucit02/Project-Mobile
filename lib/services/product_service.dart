import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shose_store/models/shoes/product.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Product>> getAllProduct() async {
    try {
      final querySnapshot =
          await _firestore
              .collection('products')
              .orderBy('id', descending: true)
              .get();
      return querySnapshot.docs
          .map((doc) => Product.fromFirestore(doc))
          .toList();
    } catch (e) {
      print("Error getting products: $e");
      return [];
    }
  }

  Stream<List<Product>> getAllProductsStream() {
    return _firestore
        .collection('products')
        .orderBy('id', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Product.fromFirestore(doc))
        .toList());
  }

}
