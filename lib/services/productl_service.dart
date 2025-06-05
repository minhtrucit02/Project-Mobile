import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:shose_store/models/shoes/product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final String baseUrl = 'https://shosestore-7c86e-default-rtdb.firebaseio.com';

  //Firebase store
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addProduct(Product product) async {
    try {
      final productCollection = _firestore.collection('products');
      final docRef = await productCollection.add(product.toJson());
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to add product: $e');
    }
  }

  //firebase database
  final _productRef = FirebaseDatabase.instance.ref().child('products');


  Future<void> addProducts(Product product) async {
    try {
      final snapshot = await _productRef.get();

      int newId = 1;
      if (snapshot.exists) {
        if (snapshot.value is Map) {
          final Map<dynamic, dynamic> data =
              snapshot.value as Map<dynamic, dynamic>;

          final ids =
              data.keys.map((key) => int.parse(key.toString()) ?? 1).toList()
                ..sort();
          newId = (ids.isNotEmpty ? ids.last + 1 : 1);
        } else if (snapshot.value is List) {
          final List<dynamic> data = snapshot.value as List;
          final ids = <int>[];
          for (int i = 0; i < data.length; i++) {
            if (data[i] != null) {
              ids.add(i);
            }
          }
          newId = (ids.isNotEmpty ? ids.last + 1 : 1);
        }
      }
      final createAt = Timestamp.fromDate(DateTime.now());
      final newProduct = Product(
        id: newId,
        brandId: product.brandId,
        name: product.name,
        price: product.price,
        imageDetail: product.imageDetail,
        productSize: product.productSize,
        description: product.description,
        createAt: createAt,
      );
      await _productRef.child(newId.toString()).set(newProduct.toJson());
    } catch (e) {
      print("Bug: $e");
      rethrow;
    }
  }

  Future<List<Product>> getAllProducts() async {
    try{
      final response = await http.get(Uri.parse('$baseUrl/products.json'));
      if(response.statusCode == 200){
        final data = json.decode(response.body);
        final List<Product> products = [];

        if(data!= null && data is List){
          for(var item in data){
            if(item!= null && item is Map<String, dynamic>){
              try{
                final product = Product.fromRealtime(item);
                products.add(product);
              }catch(e){
                print("Lỗi khi parse product: $e | Dữ liệu: $item");
              }
            }
          }

          products.sort((a,b) => a.id.compareTo(b.id));
          return products;
        }else{
          print("Dữ liệu không hợp lệ: $data");
          return [];
        }
      } else{
        throw Exception('Lỗi khi tải dữ liệu: ${response.statusCode}');
      }
    }catch(e){
      print('Lỗi khi lấy danh sách product: $e');
      rethrow;
    }
  }

}
