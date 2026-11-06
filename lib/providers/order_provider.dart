import 'package:flutter/foundation.dart';

import '../models/order_model.dart';

class OrderProvider extends ChangeNotifier {
  final List<OrderModel> _orders = [];

  List<OrderModel> get orders => List.unmodifiable(_orders);

  OrderModel? get latestOrder {
    if (_orders.isEmpty) return null;
    return _orders.last;
  }

  void addOrder(OrderModel order) {
    _orders.add(order);
    notifyListeners();
  }

  void updateOrderStatus(String orderId, String status) {
    final index = _orders.indexWhere(
      (order) => order.id == orderId,
    );

    if (index == -1) return;

    final oldOrder = _orders[index];

    _orders[index] = OrderModel(
      id: oldOrder.id,
      items: oldOrder.items,
      totalPrice: oldOrder.totalPrice,
      paymentMethod: oldOrder.paymentMethod,
      status: status,
      createdAt: oldOrder.createdAt,
    );

    notifyListeners();
  }
}