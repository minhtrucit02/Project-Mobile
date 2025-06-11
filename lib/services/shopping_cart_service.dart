import 'package:shose_store/models/shoes/cart_item.dart';

abstract class ShoppingCartService {
  Future<void> addShoppingCart(CartItem cartItem);
  Future<List<CartItem>> getAllShoppingCart(String userId);
}