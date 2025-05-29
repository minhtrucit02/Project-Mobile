import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shose_store/models/shoes/product.dart';

class ProductService{
  Future<String> addProduct(Product product) async{
    try{
      final productCollection = FirebaseFirestore.instance.collection('products');
      final docRef = await productCollection.add(product.toJson());
      return docRef.id;
    }catch(e){
      throw Exception('Failed to add product: $e');
    }
  }
}