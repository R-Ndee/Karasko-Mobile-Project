
import 'package:flutter/foundation.dart';

import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get totalItems {
    return _items.fold(0, (total, item) => total + item.quantity);
  }

  int get totalPrice {
    return _items.fold(0, (total, item) => total + item.subtotal);
  }

  bool get isEmpty => _items.isEmpty;

  void addItem(
    Product product, {
    String size = 'Medium',
    int sizeVolumeMl = 350,
    int sizeExtraPrice = 0,
    String temperature = 'Iced',
    String sugarLevel = 'Less Sugar',
    String iceLevel = 'Normal Ice',
    int quantity = 1,
  }) {
    if (quantity < 1) return;

    final newItem = CartItem(
      product: product,
      size: size,
      sizeVolumeMl: sizeVolumeMl,
      sizeExtraPrice: sizeExtraPrice,
      temperature: temperature,
      sugarLevel: sugarLevel,
      iceLevel: iceLevel,
      quantity: quantity,
    );

    final index = _items.indexWhere(
      (item) => item.cartItemId == newItem.cartItemId,
    );

    if (index >= 0) {
      _items[index].quantity += quantity;
    } else {
      _items.add(newItem);
    }

    notifyListeners();
  }

  int _findItemIndex(String itemId) {
    final exactIndex = _items.indexWhere(
      (item) => item.cartItemId == itemId,
    );

    if (exactIndex >= 0) return exactIndex;

    return _items.indexWhere(
      (item) => item.product.id == itemId,
    );
  }

  void increaseQuantity(String productId) {
    final index = _findItemIndex(productId);

    if (index < 0) return;

    _items[index].quantity++;
    notifyListeners();
  }

  void decreaseQuantity(String productId) {
    final index = _findItemIndex(productId);

    if (index < 0) return;

    if (_items[index].quantity > 1) {
      _items[index].quantity--;
    } else {
      _items.removeAt(index);
    }

    notifyListeners();
  }

  void removeItem(String productId) {
    final exactIndex = _items.indexWhere(
      (item) => item.cartItemId == productId,
    );

    if (exactIndex >= 0) {
      _items.removeAt(exactIndex);
    } else {
      _items.removeWhere(
        (item) => item.product.id == productId,
      );
    }

    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
