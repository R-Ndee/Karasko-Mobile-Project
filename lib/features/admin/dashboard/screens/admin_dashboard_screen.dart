
import 'package:flutter/material.dart';

import '../../../../core/constants/themes/color_constants.dart';
import '../../../../core/constants/themes/size_constants.dart';
import '../../../../core/constants/themes/typography_constants.dart';
import '../../../auth/screens/login_screen.dart';
import '../../../customer/navigation/customer_navigation.dart';
import '../../orders/screens/admin_order_list_screen.dart';
import '../../products/screens/admin_product_list_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToOrders() {
    setState(() {
      _selectedIndex = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      _DashboardContent(onViewAllOrders: _navigateToOrders),
      const AdminProductListScreen(),
      const AdminOrderListScreen(),
      const _AdminProfilePlaceholder(),
    ];
    return Scaffold(
      backgroundColor: BaseColor.cream,
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: BaseColor.white,
        selectedItemColor: BaseColor.karasko,
        unselectedItemColor: Colors.grey.shade500,
        selectedLabelStyle: BaseTypography.labelSmall.copyWith(
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: BaseTypography.labelSmall,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            activeIcon: Icon(Icons.inventory_2),
            label: 'Produk',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent({this.onViewAllOrders});

  final VoidCallback? onViewAllOrders;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          BaseSize.s20,
          BaseSize.s20,
          BaseSize.s20,
          BaseSize.s32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Gap.h24,
            const _RevenueCard(),
            Gap.h28,
            Text(
              'Ringkasan Bisnis',
              style: BaseTypography.headlineSmall,
            ),
            Gap.h6,
            Text(
              'Gambaran singkat performa tokomu',
              style: BaseTypography.bodySmall.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            Gap.h16,
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _StatisticCard(
                    title: 'Total Pesanan',
                    value: '128',
                    icon: Icons.shopping_bag_outlined,
                    description: 'Pesanan masuk',
                  ),
                ),
                Gap.w12,
                Expanded(
                  child: _StatisticCard(
                    title: 'Total Produk',
                    value: '32',
                    icon: Icons.inventory_2_outlined,
                    description: 'Produk tersedia',
                  ),
                ),
              ],
            ),
            Gap.h24,
            const _SalesChartCard(),
            Gap.h28,
            _RecentOrdersSection(onViewAll: onViewAllOrders),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'KARASKO ADMIN',
                style: BaseTypography.labelSmall.copyWith(
                  color: BaseColor.caramel,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
              Gap.h6,
              Text(
                'Selamat datang, Admin',
                style: BaseTypography.headlineMedium,
              ),
              Gap.h4,
              Text(
                'Pantau perkembangan tokomu hari ini.',
                style: BaseTypography.bodySmall.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: BaseColor.karasko,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.notifications_none_rounded,
            color: BaseColor.white,
            size: 22,
          ),
        ),
      ],
    );
  }
}

class _RevenueCard extends StatelessWidget {
  const _RevenueCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(BaseSize.s20),
      decoration: BoxDecoration(
        color: BaseColor.karasko,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TOTAL PENDAPATAN',
                style: BaseTypography.labelSmall.copyWith(
                  color: BaseColor.white.withValues(alpha: 0.75),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              Icon(
                Icons.account_balance_wallet_outlined,
                size: 19,
                color: BaseColor.white.withValues(alpha: 0.7),
              ),
            ],
          ),
          Gap.h12,
          Text(
            'Rp 4.850.000',
            style: BaseTypography.displaySmall.copyWith(
              color: BaseColor.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          Gap.h12,
          Row(
            children: [
              const Icon(
                Icons.trending_up_rounded,
                color: Color(0xFF9BD5A8),
                size: 18,
              ),
              Gap.w6,
              Flexible(
                child: Text(
                  '12,5% dibanding periode sebelumnya',
                  style: BaseTypography.bodySmall.copyWith(
                    color: const Color(0xFFB9E0C2),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatisticCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final String description;

  const _StatisticCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(BaseSize.s16),
      decoration: BoxDecoration(
        color: BaseColor.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: BaseColor.charcoal.withValues(alpha: 0.07),
        ),
        boxShadow: [
          BoxShadow(
            color: BaseColor.charcoal.withValues(alpha: 0.025),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: BaseColor.cream,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: BaseColor.caramel,
              size: 21,
            ),
          ),
          Gap.h14,
          Text(
            value,
            style: BaseTypography.displaySmall.copyWith(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          Gap.h4,
          Text(
            title,
            style: BaseTypography.titleSmall.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap.h4,
          Text(
            description,
            style: BaseTypography.bodySmall.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SalesChartCard extends StatelessWidget {
  const _SalesChartCard();

  static const List<double> _sales = [
    30, 48, 38, 65, 52, 80, 60,
  ];

  static const List<String> _days = [
    'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(BaseSize.s16),
      decoration: BoxDecoration(
        color: BaseColor.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: BaseColor.charcoal.withValues(alpha: 0.07),
        ),
        boxShadow: [
          BoxShadow(
            color: BaseColor.charcoal.withValues(alpha: 0.025),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Penjualan Mingguan',
            style: BaseTypography.headlineSmall,
          ),
          Gap.h4,
          Text(
            'Statistik penjualan 7 hari terakhir',
            style: BaseTypography.bodySmall.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
          Gap.h24,
          SizedBox(
            height: 155,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(
                _sales.length,
                (index) {
                  final isHighest = _sales[index] == 80;

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 3,
                      ),
                      child: Column(
                        children: [
                          Text(
                            _sales[index].toInt().toString(),
                            style: BaseTypography.labelSmall.copyWith(
                              color: isHighest
                                  ? BaseColor.karasko
                                  : Colors.grey.shade600,
                              fontWeight: isHighest
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                          Gap.h8,
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: FractionallySizedBox(
                                heightFactor: _sales[index] / 100,
                                widthFactor: 0.72,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isHighest
                                        ? BaseColor.karasko
                                        : BaseColor.karasko.withValues(
                                            alpha: 0.22,
                                          ),
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Gap.h8,
                          Text(
                            _days[index],
                            style: BaseTypography.labelSmall.copyWith(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentOrdersSection extends StatelessWidget {
  const _RecentOrdersSection({this.onViewAll});

  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pesanan Terbaru',
              style: BaseTypography.headlineSmall,
            ),
            TextButton(
              onPressed: onViewAll,
              style: TextButton.styleFrom(
                foregroundColor: BaseColor.caramel,
                padding: const EdgeInsets.symmetric(horizontal: 4),
              ),
              child: Text(
                'Lihat semua',
                style: BaseTypography.labelMedium.copyWith(
                  color: BaseColor.caramel,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        Gap.h8,
        const _OrderItem(
          orderId: 'ORD-00128',
          details: '2 item',
          total: 'Rp 68.000',
          status: 'Selesai',
          statusColor: Color(0xFF28734F),
        ),
        Gap.h10,
        const _OrderItem(
          orderId: 'ORD-00127',
          details: '3 item',
          total: 'Rp 95.000',
          status: 'Diproses',
          statusColor: BaseColor.caramel,
        ),
        Gap.h10,
        const _OrderItem(
          orderId: 'ORD-00126',
          details: '1 item',
          total: 'Rp 32.000',
          status: 'Menunggu',
          statusColor: Color(0xFFB7791F),
        ),
      ],
    );
  }
}

class _OrderItem extends StatelessWidget {
  final String orderId;
  final String details;
  final String total;
  final String status;
  final Color statusColor;

  const _OrderItem({
    required this.orderId,
    required this.details,
    required this.total,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(BaseSize.s16),
      decoration: BoxDecoration(
        color: BaseColor.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: BaseColor.charcoal.withValues(alpha: 0.07),
        ),
        boxShadow: [
          BoxShadow(
            color: BaseColor.charcoal.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: BaseColor.cream,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.receipt_long_outlined,
              color: BaseColor.karasko,
              size: 21,
            ),
          ),
          Gap.w12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderId,
                  style: BaseTypography.titleSmall.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gap.h4,
                Text(
                  details,
                  style: BaseTypography.bodySmall.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                total,
                style: BaseTypography.titleSmall.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gap.h6,
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: BaseSize.s10,
                  vertical: BaseSize.s4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: BaseTypography.labelSmall.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AdminProfilePlaceholder extends StatelessWidget {
  const _AdminProfilePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColor.cream,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 1,
        shadowColor: BaseColor.karasko.withValues(alpha: 0.12),
        title: Text(
          'Profil Admin',
          style: BaseTypography.headlineSmall.copyWith(
            fontWeight: FontWeight.w800,
            color: BaseColor.karasko,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(BaseSize.s24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 46,
                backgroundColor: BaseColor.karasko.withValues(alpha: 0.1),
                child: const Icon(
                  Icons.admin_panel_settings,
                  size: 50,
                  color: BaseColor.karasko,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Administrator Karasko',
                style: BaseTypography.headlineMedium.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'admin@karasko.com',
                style: BaseTypography.bodyMedium.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 36),
              Container(
                decoration: BoxDecoration(
                  color: BaseColor.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: BaseColor.charcoal.withValues(alpha: 0.07),
                  ),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.storefront_outlined,
                        color: BaseColor.karasko,
                      ),
                      title: Text(
                        'Beralih ke Tampilan Pelanggan',
                        style: BaseTypography.titleSmall.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        'Buka mode pelanggan untuk memesan kopi',
                        style: BaseTypography.bodySmall.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CustomerNavigation(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(
                        Icons.logout,
                        color: Color(0xFFB34B43),
                      ),
                      title: Text(
                        'Keluar',
                        style: BaseTypography.titleSmall.copyWith(
                          color: const Color(0xFFB34B43),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
