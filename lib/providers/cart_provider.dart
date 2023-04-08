import 'package:ecom_demo/models/cart_item.dart';
import 'package:flutter/foundation.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  double get totalPrice => _cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);

  int get itemCount => _cartItems.length;

  void addItem(CartItem item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeItem(CartItem item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  void clear() {
    _cartItems.clear();
    notifyListeners();
  }

  void updateQuantity(CartItem item, int quantity) {
    item.quantity = quantity;
    notifyListeners();
  }
}
