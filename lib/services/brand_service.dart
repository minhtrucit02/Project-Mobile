import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:shose_store/models/shoes/brand.dart';

class BrandService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Brand>> getAllBrands() async {
    try {
      final querySnapshot =
          await _firestore
              .collection('brands')
              .orderBy('id', descending: true)
              .get();
      return querySnapshot.docs
          .map((doc) => Brand.fromFirestore(doc))
          .toList();
    } catch (e) {
      print("Error getting products: $e");
      return [];
    }
  }

  Stream<List<Brand>> getAllBrandsStream() {
    return _firestore
        .collection('brands')
        .orderBy('id', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Brand.fromFirestore(doc))
        .toList());
  }

  Future<String> addBrand(Brand brand) async {
    try {
      final brandCollection = FirebaseFirestore.instance.collection('brands');
      final docRef = await brandCollection.add(brand.toMap());
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to add brand: $e');
    }
  }

  String formattedDate(Timestamp timestamp) {
    return DateFormat('yyyy-MM-dd').format(timestamp.toDate());
  }
}
