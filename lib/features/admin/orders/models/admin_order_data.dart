enum AdminOrderStatus { newOrder, preparing, ready, completed, cancelled }

class AdminOrderLine {
  const AdminOrderLine({
    required this.name,
    required this.customization,
    required this.quantity,
    required this.unitPrice,
  });

  final String name;
  final String customization;
  final int quantity;
  final int unitPrice;

  int get total => quantity * unitPrice;
}

class AdminOrderData {
  const AdminOrderData({
    required this.id,
    required this.customerName,
    required this.timeLabel,
    required this.status,
    required this.items,
    required this.paymentMethod,
    this.note,
  });

  final String id;
  final String customerName;
  final String timeLabel;
  final AdminOrderStatus status;
  final List<AdminOrderLine> items;
  final String paymentMethod;
  final String? note;

  int get total => items.fold(0, (sum, item) => sum + item.total);

  AdminOrderData copyWith({AdminOrderStatus? status}) {
    return AdminOrderData(
      id: id,
      customerName: customerName,
      timeLabel: timeLabel,
      status: status ?? this.status,
      items: items,
      paymentMethod: paymentMethod,
      note: note,
    );
  }
}

String formatAdminCurrency(int amount) {
  return amount.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => '.',
  );
}
