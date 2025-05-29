import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shose_store/models/shoes/productSize.dart';

class SizeService {
  Future<String> addSize(ProductSize productSize) async {
    try{
      final sizeCollection = FirebaseFirestore.instance.collection("size");
      final docRef = await sizeCollection.add(productSize.toJson());
      return docRef.id;
    } catch (e){
      throw Exception("Error to add size $e");
    }
  }
}