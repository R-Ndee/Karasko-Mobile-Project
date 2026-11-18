
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/cart_item.dart';
import '../../../../models/order_model.dart';
import '../../../../providers/order_provider.dart';

class ActiveOrderScreen extends StatelessWidget {
  const ActiveOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F7),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF9F9F7),
          foregroundColor: const Color(0xFF1A1C1B),
          elevation: 0,
          centerTitle: false,
          title: const Text(
            'Pesanan',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1C1B),
            ),
          ),
          bottom: const TabBar(
            labelColor: Color(0xFF032217),
            unselectedLabelColor: Color(0xFF727974),
            indicatorColor: Color(0xFF032217),
            indicatorWeight: 3,
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            tabs: [
              Tab(text: 'Aktif'),
              Tab(text: 'Riwayat'),
            ],
          ),
        ),
        body: Consumer<OrderProvider>(
          builder: (context, orderProvider, child) {
            final allOrders = orderProvider.orders.reversed.toList();

            final activeOrders = allOrders.where((order) {
              return order.status != 'Selesai' &&
                  order.status != 'Dibatalkan';
            }).toList();

            final historyOrders = allOrders.where((order) {
              return order.status == 'Selesai' ||
                  order.status == 'Dibatalkan';
            }).toList();

            return TabBarView(
              children: [
                _buildOrderList(
                  context,
                  activeOrders,
                  isHistory: false,
                ),
                _buildOrderList(
                  context,
                  historyOrders,
                  isHistory: true,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildOrderList(
    BuildContext context,
    List<OrderModel> orders, {
    required bool isHistory,
  }) {
    if (orders.isEmpty) {
      return _buildEmptyState(isHistory: isHistory);
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      itemCount: orders.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return _buildOrderCard(context, orders[index]);
      },
    );
  }

  Widget _buildEmptyState({required bool isHistory}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: const Color(0xFFEEEEEC),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Icon(
                isHistory
                    ? Icons.receipt_long_outlined
                    : Icons.coffee_outlined,
                size: 38,
                color: const Color(0xFF727974),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              isHistory
                  ? 'Belum Ada Riwayat'
                  : 'Belum Ada Pesanan Aktif',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1C1B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isHistory
                  ? 'Pesanan yang sudah selesai atau dibatalkan akan muncul di sini.'
                  : 'Pesanan yang sedang diproses akan muncul di sini.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                height: 1.5,
                color: Color(0xFF727974),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, OrderModel order) {
    final isCancelled = order.status == 'Dibatalkan';
    final isCompleted = order.status == 'Selesai';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE8E8E6),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderHeader(order),
            const SizedBox(height: 16),
            const Divider(color: Color(0xFFE8E8E6)),
            const SizedBox(height: 16),
            if (isCancelled)
              _buildCancelledBanner()
            else
              _buildOrderProgress(order.status),
            const SizedBox(height: 18),
            _buildSectionTitle('Detail Pesanan'),
            const SizedBox(height: 12),
            ...order.items.map(_buildOrderItem),
            const SizedBox(height: 16),
            const Divider(color: Color(0xFFE8E8E6)),
            const SizedBox(height: 14),
            _buildSectionTitle('Informasi Pesanan'),
            const SizedBox(height: 12),
            _buildInfoRow('Tipe Pesanan', order.orderType),
            _buildInfoRow('Metode Pembayaran', order.paymentMethod),
            _buildInfoRow(
              'Kemasan Ramah Lingkungan',
              order.useEcoPackaging ? 'Ya' : 'Tidak',
            ),
            if (order.orderNote.trim().isNotEmpty)
              _buildInfoRow('Catatan', order.orderNote),
            const SizedBox(height: 14),
            const Divider(color: Color(0xFFE8E8E6)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Pembayaran',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF424844),
                  ),
                ),
                Text(
                  _formatCurrency(order.totalPrice),
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF032217),
                  ),
                ),
              ],
            ),
            if (!isCancelled && !isCompleted) ...[
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _showOrderCode(
                    context: context,
                    order: order,
                  ),
                  icon: const Icon(Icons.qr_code_2, size: 19),
                  label: const Text('Tunjukkan Kode Pesanan'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF032217),
                    side: const BorderSide(
                      color: Color(0xFF032217),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildOrderHeader(OrderModel order) {
    final date = order.createdAt;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order.id,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF032217),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${_formatDate(date)} • ${_formatTime(date)}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF727974),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        _buildStatusBadge(order.status),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    final color = _getStatusColor(status);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }

  Widget _buildOrderProgress(String status) {
    const steps = [
      'Diterima',
      'Disiapkan',
      'Siap Ambil',
      'Selesai',
    ];

    final currentStep = _getStatusStep(status);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Status Pesanan'),
        const SizedBox(height: 16),
        Row(
          children: List.generate(steps.length, (index) {
            final isCompleted = index <= currentStep;
            final isLast = index == steps.length - 1;

            return Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 27,
                          height: 27,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isCompleted
                                ? const Color(0xFF032217)
                                : const Color(0xFFEEEEEC),
                          ),
                          child: Icon(
                            isCompleted
                                ? Icons.check
                                : Icons.circle,
                            size: isCompleted ? 15 : 7,
                            color: isCompleted
                                ? Colors.white
                                : const Color(0xFFC1C8C2),
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          steps[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: isCompleted
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: isCompleted
                                ? const Color(0xFF032217)
                                : const Color(0xFF727974),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        height: 2,
                        margin: const EdgeInsets.only(
                          bottom: 22,
                        ),
                        color: index < currentStep
                            ? const Color(0xFF032217)
                            : const Color(0xFFE8E8E6),
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildCancelledBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFB3261E).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.cancel_outlined,
            color: Color(0xFFB3261E),
            size: 20,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Pesanan ini telah dibatalkan.',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFFB3261E),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(CartItem item) {
    final customization = [
      item.size,
      '${item.sizeVolumeMl} ml',
      item.temperature,
      item.sugarLevel,
      if (item.temperature == 'Iced') item.iceLevel,
    ].join(' • ');

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF4F4F1),
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(
              Icons.coffee_outlined,
              color: Color(0xFF845326),
              size: 21,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1C1B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  customization,
                  style: const TextStyle(
                    fontSize: 10,
                    height: 1.4,
                    color: Color(0xFF727974),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${item.quantity} × ${_formatCurrency(item.unitPrice)}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF424844),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            _formatCurrency(item.subtotal),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1C1B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: Color(0xFF1A1C1B),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF727974),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1C1B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showOrderCode({
    required BuildContext context,
    required OrderModel order,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.qr_code_2,
                  size: 76,
                  color: Color(0xFF032217),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Kode Pesanan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A1C1B),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tunjukkan kode ini kepada barista saat mengambil pesanan.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    color: Color(0xFF727974),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F4F1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SelectableText(
                    order.id,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                      color: Color(0xFF032217),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF032217),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Tutup'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  int _getStatusStep(String status) {
    switch (status) {
      case 'Diterima':
        return 0;
      case 'Disiapkan':
        return 1;
      case 'Siap Ambil':
        return 2;
      case 'Selesai':
        return 3;
      default:
        return 0;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Diterima':
        return const Color(0xFF845326);
      case 'Disiapkan':
        return const Color(0xFF356A9A);
      case 'Siap Ambil':
        return const Color(0xFF27805A);
      case 'Selesai':
        return const Color(0xFF032217);
      case 'Dibatalkan':
        return const Color(0xFFB3261E);
      default:
        return const Color(0xFF727974);
    }
  }

  String _formatCurrency(int amount) {
    final value = amount.toString();
    final buffer = StringBuffer();

    for (int i = 0; i < value.length; i++) {
      buffer.write(value[i]);

      final remaining = value.length - i - 1;
      if (remaining > 0 && remaining % 3 == 0) {
        buffer.write('.');
      }
    }

    return 'Rp$buffer';
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }
}
