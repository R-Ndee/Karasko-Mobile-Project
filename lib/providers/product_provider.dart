
import 'package:flutter/foundation.dart';

import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> _products;

  ProductProvider({
    List<Product> initialProducts = const [],
  }) : _products = List<Product>.of(initialProducts);

  List<Product> get products => List.unmodifiable(_products);

  int get totalProducts => _products.length;

  List<String> get categories {
    return _products
        .map((product) => product.category)
        .toSet()
        .toList();
  }

  List<Product> getProductsByCategory(String category) {
    return _products
        .where((product) => product.category == category)
        .toList();
  }

  Product? getProductById(String id) {
    for (final product in _products) {
      if (product.id == id) {
        return product;
      }
    }

    return null;
  }

  bool addProduct(Product product) {
    final alreadyExists = _products.any(
      (item) => item.id == product.id,
    );

    if (alreadyExists) return false;

    _products.add(product);
    notifyListeners();

    return true;
  }

  bool updateProduct(String id, Product updatedProduct) {
    final index = _products.indexWhere(
      (product) => product.id == id,
    );

    if (index == -1 || updatedProduct.id != id) {
      return false;
    }

    _products[index] = updatedProduct;
    notifyListeners();

    return true;
  }

  bool deleteProduct(String id) {
    final index = _products.indexWhere(
      (product) => product.id == id,
    );

    if (index == -1) return false;

    _products.removeAt(index);
    notifyListeners();

    return true;
  }
}
