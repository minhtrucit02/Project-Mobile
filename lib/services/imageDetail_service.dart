import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shose_store/models/shoes/imageDetail.dart';

class ImageDetailService {

  Future<String> addImageDetail(ImageDetail imageDetail) async {
    try{
      final imageDetailCollection = FirebaseFirestore.instance.collection("imageDetail");
      final docRef = await imageDetailCollection.add(imageDetail.toJson());
      return docRef.id;
    }catch (e){
      throw Exception("Error to add image: $e ");
    }
  }
}