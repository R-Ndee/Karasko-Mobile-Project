
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:karasko_mobile_project/features/admin/dashboard/screens/admin_dashboard_screen.dart';

import '../../../../models/order_model.dart';
import '../../../../providers/order_provider.dart';
import '../../navigation/customer_navigation.dart';

class HomeScreen extends StatelessWidget {
  final bool showBottomNav;
  final ValueChanged<int>? onNavigate;

  const HomeScreen({
    super.key,
    this.showBottomNav = true,
    this.onNavigate,
  });

  void _navigateTo(BuildContext context, int index) {
    if (onNavigate != null) {
      onNavigate!(index);
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => CustomerNavigation(
          initialIndex: index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F7),
      appBar: AppBar(
        toolbarHeight: 64,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFF9F9F7),
        foregroundColor: const Color(0xFF1A1C1B),
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 20,
        title: Row(
          children: [
            const Icon(
              Icons.coffee_maker,
              color: Color(0xFF032217),
              size: 25,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Karasko',
                        style: TextStyle(
                          color: Color(0xFF032217),
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(width: 7),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8EEE9),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'MANADO',
                          style: TextStyle(
                            color: Color(0xFF032217),
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  const Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: Color(0xFF68A987),
                        size: 6,
                      ),
                      SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          'Buka • Kedai Terpilih',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color(0xFF727974),
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AdminDashboardScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.storefront_outlined,
                size: 17,
              ),
              label: const Text('Admin'),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF845326),
                backgroundColor: const Color(0xFFEEEEEC),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                minimumSize: const Size(0, 36),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
                textStyle: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFFE8E8E6),
              child: Icon(
                Icons.person_outline,
                color: Color(0xFF424844),
                size: 19,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGreetingCard(),
            const SizedBox(height: 20),
            _buildActiveOrderWidget(context),
            const SizedBox(height: 24),
            const Text(
              'Jelajahi Menu',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF032217),
              ),
            ),
            const SizedBox(height: 12),
            _buildMenuPrompt(context),
          ],
        ),
      ),
      bottomNavigationBar: showBottomNav
          ? CustomerBottomNavBar(
              currentIndex: 0,
              onTap: (index) {
                if (index != 0) {
                  _navigateTo(context, index);
                }
              },
            )
          : null,
    );
  }

  Widget _buildGreetingCard() {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFF032217),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -48,
            top: -55,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF527363).withValues(alpha: 0.35),
                ),
              ),
            ),
          ),
          Positioned(
            right: -18,
            bottom: -85,
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF1A382B).withValues(alpha: 0.7),
              ),
            ),
          ),
          Positioned(
            right: 24,
            top: 42,
            child: Icon(
              Icons.coffee,
              size: 82,
              color: const Color(0xFFC9A77C).withValues(alpha: 0.85),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 22,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A382B),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: const Color(0xFF527363),
                      width: 0.6,
                    ),
                  ),
                  child: const Text(
                    'YOUR DAILY BREW',
                    style: TextStyle(
                      color: Color(0xFFD5B995),
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const SizedBox(
                  width: 245,
                  child: Text(
                    'Selamat Pagi,\nTrituwat',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                      letterSpacing: -0.7,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(
                  width: 235,
                  child: Text(
                    'Awali harimu dengan secangkir kopi artisanal pilihan Karasko.',
                    style: TextStyle(
                      color: Color(0xFFB4C5BA),
                      fontSize: 12,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveOrderWidget(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) {
        final activeOrder = _findLatestActiveOrder(
          orderProvider.orders,
        );

        return Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              _navigateTo(
                context,
                activeOrder == null ? 1 : 3,
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFE8E8E6),
                ),
              ),
              child: activeOrder == null
                  ? _buildEmptyOrderContent()
                  : _buildOrderContent(activeOrder),
            ),
          ),
        );
      },
    );
  }

  OrderModel? _findLatestActiveOrder(List<OrderModel> orders) {
    for (final order in orders.reversed) {
      if (order.status != 'Selesai' &&
          order.status != 'Dibatalkan') {
        return order;
      }
    }

    return null;
  }

  Widget _buildEmptyOrderContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(
              Icons.receipt_long_outlined,
              color: Color(0xFF845326),
              size: 15,
            ),
            SizedBox(width: 6),
            Text(
              'PESANAN AKTIF',
              style: TextStyle(
                color: Color(0xFF845326),
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const _OrderCoffeeIcon(),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Belum ada pesanan',
                    style: TextStyle(
                      color: Color(0xFF1A1C1B),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Pesananmu akan muncul di sini setelah pembayaran.',
                    style: TextStyle(
                      color: Color(0xFF727974),
                      fontSize: 11,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color(0xFF727974),
              size: 14,
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(
          height: 1,
          color: Color(0xFFE8E8E6),
        ),
        const SizedBox(height: 12),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ingin menikmati kopi hari ini?',
              style: TextStyle(
                color: Color(0xFF727974),
                fontSize: 11,
              ),
            ),
            Row(
              children: [
                Text(
                  'Lihat Menu',
                  style: TextStyle(
                    color: Color(0xFF032217),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: Color(0xFF032217),
                  size: 14,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOrderContent(OrderModel order) {
    final totalItems = order.items.fold<int>(
      0,
      (total, item) => total + item.quantity,
    );

    final firstProduct = order.items.isNotEmpty
        ? order.items.first.product.name
        : 'Pesanan Karasko';

    final additionalProducts = order.items.length - 1;
    final statusPresentation = _getStatusPresentation(order.status);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  color: Color(0xFF845326),
                  size: 15,
                ),
                SizedBox(width: 6),
                Text(
                  'PESANAN AKTIF',
                  style: TextStyle(
                    color: Color(0xFF845326),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: statusPresentation.background,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.circle,
                      color: statusPresentation.foreground,
                      size: 6,
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        statusPresentation.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: statusPresentation.foreground,
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const _OrderCoffeeIcon(),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    firstProduct,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF1A1C1B),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    additionalProducts > 0
                        ? '$totalItems item • +$additionalProducts jenis menu lainnya'
                        : '$totalItems item • Pesanan #${order.id}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF727974),
                      fontSize: 11,
                    ),
                  ),
                  if (additionalProducts > 0) ...[
                    const SizedBox(height: 3),
                    Text(
                      'Pesanan #${order.id}',
                      style: const TextStyle(
                        color: Color(0xFF727974),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color(0xFF727974),
              size: 14,
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(
          height: 1,
          color: Color(0xFFE8E8E6),
        ),
        const SizedBox(height: 12),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Lihat perkembangan pesanan',
              style: TextStyle(
                color: Color(0xFF727974),
                fontSize: 11,
              ),
            ),
            Row(
              children: [
                Text(
                  'Pantau Pesanan',
                  style: TextStyle(
                    color: Color(0xFF032217),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: Color(0xFF032217),
                  size: 14,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMenuPrompt(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => _navigateTo(context, 1),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFE8E8E6),
          ),
        ),
        child: const Row(
          children: [
            Icon(
              Icons.local_cafe_outlined,
              color: Color(0xFF845326),
              size: 20,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Temukan kopi favoritmu di menu Karasko.',
                style: TextStyle(
                  color: Color(0xFF424844),
                  fontSize: 12,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color(0xFF727974),
              size: 13,
            ),
          ],
        ),
      ),
    );
  }

  _OrderStatusPresentation _getStatusPresentation(String status) {
    switch (status) {
      case 'Diterima':
        return const _OrderStatusPresentation(
          label: 'Pesanan diterima',
          foreground: Color(0xFF845326),
          background: Color(0xFFFFF3E8),
        );
      case 'Disiapkan':
        return const _OrderStatusPresentation(
          label: 'Sedang disiapkan',
          foreground: Color(0xFF845326),
          background: Color(0xFFFFF3E8),
        );
      case 'Siap Ambil':
        return const _OrderStatusPresentation(
          label: 'Siap diambil',
          foreground: Color(0xFF28734D),
          background: Color(0xFFE8F3EC),
        );
      default:
        return const _OrderStatusPresentation(
          label: 'Menunggu konfirmasi',
          foreground: Color(0xFF727974),
          background: Color(0xFFEEEEEC),
        );
    }
  }
}

class _OrderCoffeeIcon extends StatelessWidget {
  const _OrderCoffeeIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F0E9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(
        Icons.coffee_maker_outlined,
        color: Color(0xFF845326),
        size: 23,
      ),
    );
  }
}

class _OrderStatusPresentation {
  final String label;
  final Color foreground;
  final Color background;

  const _OrderStatusPresentation({
    required this.label,
    required this.foreground,
    required this.background,
  });
}
