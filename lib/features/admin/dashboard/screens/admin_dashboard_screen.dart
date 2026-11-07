
import 'package:flutter/material.dart';

import '../../../../core/constants/themes/color_constants.dart';
import '../../../../core/constants/themes/size_constants.dart';
import '../../../../core/constants/themes/typography_constants.dart';
import '../../products/screens/admin_product_list_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const _DashboardContent(),
    const AdminProductListScreen(),
    const _AdminProfilePlaceholder(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColor.cream,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: BaseColor.white,
        selectedItemColor: BaseColor.karasko,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: BaseTypography.labelSmall,
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
  const _DashboardContent();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(BaseSize.s20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Gap.h24,
            const _RevenueCard(),
            Gap.h24,
            Text(
              'Ringkasan Bisnis',
              style: BaseTypography.headlineSmall,
            ),
            Gap.h12,
            const Row(
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
            Gap.h24,
            const _RecentOrdersSection(),
            Gap.h24,
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'KARASKO ADMIN',
                style: BaseTypography.labelSmall.copyWith(
                  color: BaseColor.caramel,
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
            Icons.notifications_none,
            color: BaseColor.white,
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
          Text(
            'TOTAL PENDAPATAN',
            style: BaseTypography.labelSmall.copyWith(
              color: BaseColor.white.withValues(alpha: 0.75),
              letterSpacing: 1,
            ),
          ),
          Gap.h12,
          Text(
            'Rp 4.850.000',
            style: BaseTypography.displaySmall.copyWith(
              color: BaseColor.white,
            ),
          ),
          Gap.h12,
          Row(
            children: [
              const Icon(
                Icons.trending_up,
                color: Color(0xFF9BD5A8),
                size: 18,
              ),
              Gap.w6,
              Text(
                '12,5% dibanding periode sebelumnya',
                style: BaseTypography.bodySmall.copyWith(
                  color: const Color(0xFF9BD5A8),
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
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: BaseColor.charcoal.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: BaseColor.caramel,
            size: 24,
          ),
          Gap.h12,
          Text(
            value,
            style: BaseTypography.headlineMedium,
          ),
          Gap.h4,
          Text(
            title,
            style: BaseTypography.titleSmall,
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
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: BaseColor.charcoal.withValues(alpha: 0.08),
        ),
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
            height: 140,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                _sales.length,
                (index) {
                  final isHighest = _sales[index] == 80;

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: FractionallySizedBox(
                                heightFactor: _sales[index] / 100,
                                child: Container(
                                  width: 18,
                                  decoration: BoxDecoration(
                                    color: isHighest
                                        ? BaseColor.karasko
                                        : BaseColor.karasko.withValues(
                                            alpha: 0.25,
                                          ),
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(6),
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
  const _RecentOrdersSection();

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
              onPressed: () {},
              child: const Text(
                'Lihat semua',
                style: TextStyle(
                  color: BaseColor.caramel,
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
        Gap.h12,
        const _OrderItem(
          orderId: 'ORD-00127',
          details: '3 item',
          total: 'Rp 95.000',
          status: 'Diproses',
          statusColor: BaseColor.caramel,
        ),
        Gap.h12,
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
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: BaseColor.charcoal.withValues(alpha: 0.08),
        ),
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
            ),
          ),
          Gap.w12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderId,
                  style: BaseTypography.titleMedium,
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
                style: BaseTypography.titleSmall,
              ),
              Gap.h4,
              Text(
                status,
                style: BaseTypography.labelSmall.copyWith(
                  color: statusColor,
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
    return const Scaffold(
      backgroundColor: BaseColor.cream,
      body: Center(
        child: Text('Profil Admin'),
      ),
    );
  }
}
