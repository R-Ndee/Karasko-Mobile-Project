
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/cart_item.dart';
import '../../../../models/order_model.dart';
import '../../../../providers/order_provider.dart';
import '../models/admin_order_data.dart';
import 'admin_order_detail_screen.dart';
import '../widgets/admin_order_card.dart';

class AdminOrderListScreen extends StatefulWidget {
  const AdminOrderListScreen({super.key});

  @override
  State<AdminOrderListScreen> createState() =>
      _AdminOrderListScreenState();
}

class _AdminOrderListScreenState
    extends State<AdminOrderListScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  String _query = '';
  AdminOrderStatus? _selectedStatus;

  static const Color _forest = Color(0xFF032217);
  static const Color _paper = Color(0xFFF9F9F7);
  static const Color _muted = Color(0xFF727974);
  static const Color _copper = Color(0xFF845326);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<AdminOrderData> _convertOrders(
    List<OrderModel> orders,
  ) {
    return orders.reversed.map(_toAdminOrderData).toList();
  }

  AdminOrderData _toAdminOrderData(OrderModel order) {
    return AdminOrderData(
      id: order.id,
      customerName: 'Pelanggan',
      timeLabel: _formatTime(order.createdAt),
      status: _toAdminStatus(order.status),
      items: order.items.map(_toAdminOrderLine).toList(),
      totalPrice: order.totalPrice,
      paymentMethod: order.paymentMethod,
      note: order.orderNote.isEmpty ? null : order.orderNote,
    );
  }

  AdminOrderLine _toAdminOrderLine(CartItem item) {
    return AdminOrderLine(
      name: item.product.name,
      customization: _formatCustomization(item),
      quantity: item.quantity,
      unitPrice: item.unitPrice,
    );
  }

  String _formatCustomization(CartItem item) {
    final details = <String>[
      item.size,
      '${item.sizeVolumeMl} ml',
      item.temperature,
      item.sugarLevel,
      if (item.temperature.toLowerCase() == 'iced')
        item.iceLevel,
    ];

    return details.join(' • ');
  }

  String _formatTime(DateTime dateTime) {
    final date = dateTime.toLocal();

    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');

    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');

    return '$day/$month/${date.year} • $hour:$minute';
  }

  AdminOrderStatus _toAdminStatus(String status) {
    switch (status.toLowerCase()) {
      case 'diterima':
        return AdminOrderStatus.newOrder;
      case 'disiapkan':
        return AdminOrderStatus.preparing;
      case 'siap ambil':
        return AdminOrderStatus.ready;
      case 'selesai':
        return AdminOrderStatus.completed;
      case 'dibatalkan':
        return AdminOrderStatus.cancelled;
      default:
        return AdminOrderStatus.newOrder;
    }
  }

  String _toCustomerStatus(AdminOrderStatus status) {
    switch (status) {
      case AdminOrderStatus.newOrder:
        return 'Diterima';
      case AdminOrderStatus.preparing:
        return 'Disiapkan';
      case AdminOrderStatus.ready:
        return 'Siap Ambil';
      case AdminOrderStatus.completed:
        return 'Selesai';
      case AdminOrderStatus.cancelled:
        return 'Dibatalkan';
    }
  }

  List<AdminOrderData> _filterOrders(
    List<AdminOrderData> orders,
  ) {
    return orders.where((order) {
      final matchesStatus = _selectedStatus == null ||
          order.status == _selectedStatus;

      final normalizedQuery = _query.toLowerCase().trim();

      final matchesQuery = normalizedQuery.isEmpty ||
          order.id.toLowerCase().contains(normalizedQuery) ||
          order.customerName.toLowerCase().contains(
                normalizedQuery,
              ) ||
          order.items.any(
            (item) =>
                item.name.toLowerCase().contains(
                      normalizedQuery,
                    ) ||
                item.customization.toLowerCase().contains(
                      normalizedQuery,
                    ),
          );

      return matchesStatus && matchesQuery;
    }).toList();
  }

  Future<void> _openOrder(
    AdminOrderData order,
  ) async {
    final orderProvider = context.read<OrderProvider>();

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AdminOrderDetailScreen(
          order: order,
          onStatusChanged: (updatedOrder) {
            orderProvider.updateOrderStatus(
              updatedOrder.id,
              _toCustomerStatus(updatedOrder.status),
            );
          },
        ),
      ),
    );
  }

  void _resetFilters() {
    setState(() {
      _query = '';
      _selectedStatus = null;
      _searchController.clear();
    });
  }

  String _statusLabel(AdminOrderStatus status) {
    switch (status) {
      case AdminOrderStatus.newOrder:
        return 'Diterima';
      case AdminOrderStatus.preparing:
        return 'Disiapkan';
      case AdminOrderStatus.ready:
        return 'Siap Ambil';
      case AdminOrderStatus.completed:
        return 'Selesai';
      case AdminOrderStatus.cancelled:
        return 'Dibatalkan';
    }
  }

  Widget _buildStatusFilter(
    String label,
    AdminOrderStatus? status,
  ) {
    final selected = _selectedStatus == status;

    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) {
        setState(() {
          _selectedStatus = selected ? null : status;
        });
      },
      selectedColor: _forest,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: selected ? Colors.white : _forest,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      side: BorderSide(
        color: selected ? _forest : const Color(0xFFC1C8C2),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      showCheckmark: false,
    );
  }

  Widget _buildSummary(List<AdminOrderData> orders) {
    final total = orders.length;

    final newOrders = orders
        .where((order) => order.status == AdminOrderStatus.newOrder)
        .length;

    final preparing = orders
        .where((order) => order.status == AdminOrderStatus.preparing)
        .length;

    final ready = orders
        .where((order) => order.status == AdminOrderStatus.ready)
        .length;

    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            title: 'Total',
            value: total.toString(),
            color: _forest,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _SummaryCard(
            title: 'Baru',
            value: newOrders.toString(),
            color: _copper,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _SummaryCard(
            title: 'Diproses',
            value: preparing.toString(),
            color: const Color(0xFF647B68),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _SummaryCard(
            title: 'Siap',
            value: ready.toString(),
            color: const Color(0xFF477A64),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState({
    required bool hasOrders,
  }) {
    final hasFilters = _query.isNotEmpty ||
        _selectedStatus != null;

    final title = hasOrders && hasFilters
        ? 'Pesanan tidak ditemukan'
        : 'Belum ada pesanan';

    final description = hasOrders && hasFilters
        ? 'Coba ubah kata kunci atau filter status pesanan.'
        : 'Pesanan pelanggan akan muncul di halaman ini.';

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 48,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: const Color(0xFFEEEEEC),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                hasOrders && hasFilters
                    ? Icons.search_off_rounded
                    : Icons.receipt_long_rounded,
                size: 34,
                color: _muted,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: _forest,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: _muted,
                fontSize: 13,
                height: 1.5,
              ),
            ),
            if (hasOrders && hasFilters) ...[
              const SizedBox(height: 20),
              TextButton(
                onPressed: _resetFilters,
                child: const Text(
                  'Reset Filter',
                  style: TextStyle(
                    color: _forest,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _paper,
      appBar: AppBar(
        backgroundColor: _paper,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 20,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manajemen Pesanan',
              style: TextStyle(
                color: _forest,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 3),
            Text(
              'Kelola pesanan pelanggan Karasko',
              style: TextStyle(
                color: _muted,
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, provider, child) {
          final allOrders = _convertOrders(provider.orders);
          final filteredOrders = _filterOrders(allOrders);

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  12,
                  20,
                  16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSummary(allOrders),
                    const SizedBox(height: 22),
                    TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _query = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Cari ID atau nama produk...',
                        hintStyle: const TextStyle(
                          color: _muted,
                          fontSize: 13,
                        ),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: _muted,
                        ),
                        suffixIcon: _query.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    _query = '';
                                  });
                                },
                                icon: const Icon(
                                  Icons.close_rounded,
                                  size: 19,
                                ),
                              )
                            : null,
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: Color(0xFFC1C8C2),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: Color(0xFFC1C8C2),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: _forest,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildStatusFilter('Semua', null),
                          const SizedBox(width: 8),
                          ...AdminOrderStatus.values.map(
                            (status) => Padding(
                              padding: const EdgeInsets.only(
                                right: 8,
                              ),
                              child: _buildStatusFilter(
                                _statusLabel(status),
                                status,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Daftar Pesanan',
                          style: TextStyle(
                            color: _forest,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          '${filteredOrders.length} pesanan',
                          style: const TextStyle(
                            color: _muted,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: filteredOrders.isEmpty
                    ? _buildEmptyState(
                        hasOrders: allOrders.isNotEmpty,
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(
                          20,
                          0,
                          20,
                          24,
                        ),
                        itemCount: filteredOrders.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final order = filteredOrders[index];

                          return AdminOrderCard(
                            order: order,
                            onTap: () => _openOrder(order),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.value,
    required this.color,
  });

  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE8E8E6),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF727974),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
