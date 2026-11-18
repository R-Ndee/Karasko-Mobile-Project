
import 'cart_item.dart';

class OrderModel {
  final String id;
  final List<CartItem> items;
  final int totalPrice;
  final String paymentMethod;
  final String status;
  final DateTime createdAt;
  final String orderType;
  final bool useEcoPackaging;
  final String orderNote;

  OrderModel({
    required this.id,
    required List<CartItem> items,
    required this.totalPrice,
    required this.paymentMethod,
    required this.status,
    required this.createdAt,
    this.orderType = 'Pickup',
    this.useEcoPackaging = false,
    this.orderNote = '',
  }) : items = List.unmodifiable(
          items.map(
            (item) => CartItem(
              product: item.product,
              quantity: item.quantity,
              size: item.size,
              sizeVolumeMl: item.sizeVolumeMl,
              sizeExtraPrice: item.sizeExtraPrice,
              temperature: item.temperature,
              sugarLevel: item.sugarLevel,
              iceLevel: item.iceLevel,
            ),
          ),
        );
}
