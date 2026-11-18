
import 'package:flutter/material.dart';
import 'package:karasko_mobile_project/features/admin/orders/models/admin_order_data.dart';

const _forest = Color(0xFF032217);
const _paper = Color(0xFFF8F8F5);
const _muted = Color(0xFF747C77);
const _copper = Color(0xFF9A6034);
const _outline = Color(0xFFE8E8E6);

class AdminOrderCard extends StatelessWidget {
  const AdminOrderCard({
    super.key,
    required this.order,
    required this.onTap,
  });

  final AdminOrderData order;
  final VoidCallback onTap;

  Color get _statusColor => switch (order.status) {
        AdminOrderStatus.newOrder => const Color(0xFFB36B25),
        AdminOrderStatus.preparing => const Color(0xFF386C9B),
        AdminOrderStatus.ready => const Color(0xFF36765D),
        AdminOrderStatus.completed => _forest,
        AdminOrderStatus.cancelled => const Color(0xFFB34B43),
      };

  String get _statusLabel => switch (order.status) {
        AdminOrderStatus.newOrder => 'Baru',
        AdminOrderStatus.preparing => 'Diproses',
        AdminOrderStatus.ready => 'Siap diambil',
        AdminOrderStatus.completed => 'Selesai',
        AdminOrderStatus.cancelled => 'Dibatalkan',
      };

  int get _totalQuantity {
    return order.items.fold(
      0,
      (total, item) => total + item.quantity,
    );
  }

  @override
  Widget build(BuildContext context) {
    final visibleItems = order.items.take(2).toList();
    final remainingItems = order.items.length - visibleItems.length;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _outline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '#${order.id}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _forest,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: _statusColor.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _statusLabel,
                      style: TextStyle(
                        color: _statusColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    Icons.person_outline_rounded,
                    size: 15,
                    color: _muted,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      order.customerName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _forest,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      order.timeLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        color: _muted,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1, color: _outline),
              const SizedBox(height: 11),
              if (visibleItems.isEmpty)
                const Text(
                  'Tidak ada detail produk',
                  style: TextStyle(
                    color: _muted,
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                  ),
                )
              else
                ...visibleItems.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 7),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${item.quantity}x',
                          style: const TextStyle(
                            color: _copper,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: _forest,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (remainingItems > 0)
                Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Text(
                    '+ $remainingItems menu lainnya',
                    style: const TextStyle(
                      color: _muted,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              const SizedBox(height: 9),
              Row(
                children: [
                  Text(
                    '$_totalQuantity item',
                    style: const TextStyle(
                      color: _muted,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Rp ${formatAdminCurrency(order.total)}',
                    style: const TextStyle(
                      color: _forest,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.chevron_right_rounded,
                    size: 18,
                    color: _muted,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
