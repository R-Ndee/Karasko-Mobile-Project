import 'cart_item.dart';

class OrderModel {
  final String id;
  final List<CartItem> items;
  final int totalPrice;
  final String paymentMethod;
  final String status;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required List<CartItem> items,
    required this.totalPrice,
    required this.paymentMethod,
    required this.status,
    required this.createdAt,
  }) : items = items
            .map(
              (item) => CartItem(
                product: item.product,
                quantity: item.quantity,
              ),
            )
            .toList();
}