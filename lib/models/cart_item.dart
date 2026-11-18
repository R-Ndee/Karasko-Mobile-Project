
import 'product.dart';

class CartItem {
  final Product product;
  final String size;
  final int sizeVolumeMl;
  final int sizeExtraPrice;
  final String temperature;
  final String sugarLevel;
  final String iceLevel;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
    this.size = 'Medium',
    this.sizeVolumeMl = 350,
    this.sizeExtraPrice = 0,
    this.temperature = 'Iced',
    this.sugarLevel = 'Less Sugar',
    this.iceLevel = 'Normal Ice',
  });

  String get cartItemId {
    return [
      product.id,
      size,
      sizeVolumeMl,
      temperature,
      sugarLevel,
      iceLevel,
    ].join('::');
  }

  int get unitPrice => product.price + sizeExtraPrice;

  int get subtotal => unitPrice * quantity;
}
