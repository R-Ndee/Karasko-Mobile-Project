import 'package:flutter/material.dart';
import 'package:karasko_mobile_project/features/admin/orders/models/admin_order_data.dart';
import 'package:karasko_mobile_project/features/admin/orders/screens/admin_order_detail_screen.dart';
import 'package:karasko_mobile_project/features/admin/orders/widgets/admin_order_card.dart';

const _forest = Color(0xFF032217);
const _paper = Color(0xFFF8F8F5);
const _muted = Color(0xFF747C77);
const _copper = Color(0xFF9A6034);

class AdminOrderListScreen extends StatefulWidget {
  const AdminOrderListScreen({super.key});

  @override
  State<AdminOrderListScreen> createState() => _AdminOrderListScreenState();
}

class _AdminOrderListScreenState extends State<AdminOrderListScreen> {
  final _searchController = TextEditingController();
  var _query = '';
  AdminOrderStatus? _statusFilter;

  final List<AdminOrderData> _orders = [
    const AdminOrderData(
      id: 'NG-2048',
      customerName: 'Nadia Putri',
      timeLabel: '10:42',
      status: AdminOrderStatus.newOrder,
      paymentMethod: 'QRIS · Lunas',
      note: 'Tolong siapkan tanpa sedotan.',
      items: [
        AdminOrderLine(
          name: 'North Signature Aren Latte',
          customization: 'Reguler · Ice · Normal Sugar · Less Ice',
          quantity: 2,
          unitPrice: 32000,
        ),
        AdminOrderLine(
          name: 'Cold Brew Original',
          customization: 'Large · Ice · No Sugar · Normal Ice',
          quantity: 1,
          unitPrice: 36000,
        ),
      ],
    ),
    const AdminOrderData(
      id: 'NG-2047',
      customerName: 'Raka Pratama',
      timeLabel: '10:35',
      status: AdminOrderStatus.preparing,
      paymentMethod: 'Tunai · Bayar di kasir',
      items: [
        AdminOrderLine(
          name: 'Caramel Macchiato',
          customization: 'Reguler · Hot · Normal Sugar',
          quantity: 1,
          unitPrice: 30000,
        ),
        AdminOrderLine(
          name: 'Cappuccino',
          customization: 'Reguler · Hot · Less Sugar',
          quantity: 1,
          unitPrice: 28000,
        ),
      ],
    ),
    const AdminOrderData(
      id: 'NG-2046',
      customerName: 'Dewi Anggraini',
      timeLabel: '10:28',
      status: AdminOrderStatus.ready,
      paymentMethod: 'QRIS · Lunas',
      items: [
        AdminOrderLine(
          name: 'Matcha Latte',
          customization: 'Large · Ice · Normal Sugar · Less Ice',
          quantity: 1,
          unitPrice: 34000,
        ),
      ],
    ),
    const AdminOrderData(
      id: 'NG-2045',
      customerName: 'Bima Saputra',
      timeLabel: '10:10',
      status: AdminOrderStatus.completed,
      paymentMethod: 'QRIS · Lunas',
      items: [
        AdminOrderLine(
          name: 'Kopi Susu Gula Aren',
          customization: 'Reguler · Ice · Less Sugar · Normal Ice',
          quantity: 2,
          unitPrice: 24000,
        ),
      ],
    ),
    const AdminOrderData(
      id: 'NG-2044',
      customerName: 'Sinta Maharani',
      timeLabel: '09:58',
      status: AdminOrderStatus.cancelled,
      paymentMethod: 'QRIS · Dikembalikan',
      items: [
        AdminOrderLine(
          name: 'Americano',
          customization: 'Reguler · Hot · Normal Sugar',
          quantity: 1,
          unitPrice: 22000,
        ),
      ],
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<AdminOrderData> get _filteredOrders {
    return _orders.where((order) {
      final matchesStatus =
          _statusFilter == null || order.status == _statusFilter;
      final searchable = '${order.id} ${order.customerName}'.toLowerCase();
      return matchesStatus && searchable.contains(_query.toLowerCase());
    }).toList();
  }

  Future<void> _openOrder(AdminOrderData order) async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) =>
            AdminOrderDetailScreen(order: order, onStatusChanged: _updateOrder),
      ),
    );
  }

  void _updateOrder(AdminOrderData updatedOrder) {
    setState(() {
      final index = _orders.indexWhere((order) => order.id == updatedOrder.id);
      if (index != -1) _orders[index] = updatedOrder;
    });
  }

  @override
  Widget build(BuildContext context) {
    final orders = _filteredOrders;

    return Scaffold(
      backgroundColor: _paper,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 1,
        shadowColor: _forest.withValues(alpha: 0.12),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pesanan',
              style: TextStyle(
                color: _forest,
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              'Kelola pesanan kedai',
              style: TextStyle(color: _muted, fontSize: 10),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Notifikasi',
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: _forest),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFFC8EAD7),
              child: Icon(Icons.person, color: _forest, size: 18),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PESANAN HARI INI',
                  style: TextStyle(
                    color: _copper,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _OrderMetric(
                      label: 'Baru',
                      count: _count(AdminOrderStatus.newOrder),
                      color: _copper,
                    ),
                    const SizedBox(width: 8),
                    _OrderMetric(
                      label: 'Diproses',
                      count: _count(AdminOrderStatus.preparing),
                      color: const Color(0xFF386C9B),
                    ),
                    const SizedBox(width: 8),
                    _OrderMetric(
                      label: 'Siap',
                      count: _count(AdminOrderStatus.ready),
                      color: const Color(0xFF36765D),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => _query = value.trim()),
                  decoration: InputDecoration(
                    hintText: 'Cari nomor pesanan atau pelanggan',
                    hintStyle: const TextStyle(color: _muted, fontSize: 12),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: _muted,
                      size: 19,
                    ),
                    suffixIcon: _query.isEmpty
                        ? null
                        : IconButton(
                            tooltip: 'Hapus pencarian',
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _query = '');
                            },
                            icon: const Icon(Icons.close, size: 18),
                          ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 38,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              children: [
                _StatusFilterChip(
                  label: 'Semua',
                  selected: _statusFilter == null,
                  onTap: () => setState(() => _statusFilter = null),
                ),
                for (final status in AdminOrderStatus.values) ...[
                  const SizedBox(width: 7),
                  _StatusFilterChip(
                    label: _statusLabel(status),
                    selected: _statusFilter == status,
                    onTap: () => setState(() => _statusFilter = status),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: orders.isEmpty
                ? const Center(
                    child: Text(
                      'Pesanan tidak ditemukan',
                      style: TextStyle(color: _muted, fontSize: 13),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(18, 4, 18, 24),
                    itemCount: orders.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (context, index) => AdminOrderCard(
                      order: orders[index],
                      onTap: () => _openOrder(orders[index]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  int _count(AdminOrderStatus status) =>
      _orders.where((order) => order.status == status).length;
}

String _statusLabel(AdminOrderStatus status) => switch (status) {
  AdminOrderStatus.newOrder => 'Baru',
  AdminOrderStatus.preparing => 'Diproses',
  AdminOrderStatus.ready => 'Siap diambil',
  AdminOrderStatus.completed => 'Selesai',
  AdminOrderStatus.cancelled => 'Dibatalkan',
};

class _OrderMetric extends StatelessWidget {
  const _OrderMetric({
    required this.label,
    required this.count,
    required this.color,
  });

  final String label;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$count',
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: _muted, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusFilterChip extends StatelessWidget {
  const _StatusFilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? _forest : const Color(0xFFF0F0EC),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : _forest,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
