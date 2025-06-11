import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:shose_store/models/shoes/cart_item.dart';
import 'package:shose_store/services/shopping_cart_service.dart';
import 'package:http/http.dart' as http;

class ShoppingCartServiceImpl implements ShoppingCartService {
  final String baseUrl = 'https://shosestore-7c86e-default-rtdb.firebaseio.com';
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child('shopping_carts');

  @override
  Future<void> addShoppingCart(CartItem cartItem) async {
    try {
      final newCartRef = _dbRef.push();
      await newCartRef.set(cartItem.toJson());
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  @override
  Future<List<CartItem>> getAllShoppingCart(String userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/shopping_carts.json'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data != null && data is Map<String, dynamic>) {
          List<CartItem> cartItems = [];

          for (var entry in data.entries) {
            final item = entry.value;

            if (item != null && item is Map<String, dynamic>) {
              if (item['userId'] == userId) {
                cartItems.add(CartItem.fromJson(item));
              }
            }
          }

          return cartItems;
        } else {
          return [];
        }
      } else {
        throw Exception('Lỗi khi tải dữ liệu: ${response.statusCode}');
      }
    } catch (e) {
      print('Lỗi khi lấy data theo userId: $e');
      return [];
    }
  }

  Future<void> updateShoppingCart(CartItem cartItem) async {
    try {
      final snapshot = await _dbRef
          .orderByChild('userId')
          .equalTo(cartItem.userId)
          .get();

      if (!snapshot.exists) {
        throw Exception('Cart item not found');
      }

      final data = snapshot.value as Map<dynamic, dynamic>;
      String? itemKey;

      data.forEach((key, value) {
        if (value != null) {
          final map = Map<String, dynamic>.from(value);
          if (map['productId'] == cartItem.productId && map['status'] == false) {
            itemKey = key;
          }
        }
      });

      if (itemKey == null) {
        throw Exception('Cart item not found');
      }

      await _dbRef.child(itemKey!).update(cartItem.toJson());
    } catch (e) {
      throw Exception('Failed to update cart item: $e');
    }
  }

  Future<void> deleteShoppingCart(CartItem cartItem) async {
    try {
      final snapshot = await _dbRef
          .orderByChild('userId')
          .equalTo(cartItem.userId)
          .get();

      if (!snapshot.exists) {
        throw Exception('Cart item not found');
      }

      final data = snapshot.value as Map<dynamic, dynamic>;
      String? itemKey;

      data.forEach((key, value) {
        if (value != null) {
          final map = Map<String, dynamic>.from(value);
          if (map['productId'] == cartItem.productId && map['status'] == false) {
            itemKey = key;
          }
        }
      });

      if (itemKey == null) {
        throw Exception('Cart item not found');
      }

      await _dbRef.child(itemKey!).remove();
    } catch (e) {
      throw Exception('Failed to delete cart item: $e');
    }
  }

  Future<void> checkoutCart(String userId) async {
    try {
      final snapshot = await _dbRef
          .orderByChild('userId')
          .equalTo(userId)
          .get();

      if (!snapshot.exists) return;

      final data = snapshot.value as Map<dynamic, dynamic>;
      final Map<String, dynamic> updates = {};

      data.forEach((key, value) {
        if (value != null) {
          final map = Map<String, dynamic>.from(value);
          if (map['status'] == false) {
            updates['$key/status'] = true;
          }
        }
      });

      if (updates.isNotEmpty) {
        await _dbRef.update(updates);
      }
    } catch (e) {
      throw Exception('Failed to checkout cart: $e');
    }
  }
}
