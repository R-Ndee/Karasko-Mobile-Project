
import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/cart_provider.dart';
import '../home/screens/home_screen.dart';
import '../profile/screens/profile_screen.dart';
import '../menu/screens/menu_screen.dart';
import '../cart/screens/cart_screen.dart';
import '../orders/screens/active_order_screen.dart';

class CustomerNavigation extends StatefulWidget {
  final int initialIndex;

  const CustomerNavigation({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<CustomerNavigation> createState() => _CustomerNavigationState();
}

class _CustomerNavigationState extends State<CustomerNavigation> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.initialIndex >= 0 &&
            widget.initialIndex < 5
        ? widget.initialIndex
        : 0;
  }

  void _onItemTapped(int index) {
    if (index < 0 || index >= 5) return;

    setState(() {
      _selectedIndex = index;
    });
  }

  late final List<Widget> _pages = [
    HomeScreen(
      showBottomNav: false,
      onNavigate: _onItemTapped,
    ),
    const MenuScreen(),
    const CartScreen(),
    const ActiveOrderScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: CustomerBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class CustomerBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const CustomerBottomNavBar({
    super.key,
    this.currentIndex = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final totalItems = context.watch<CartProvider>().totalItems;

    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x0F1A382B),
            blurRadius: 24,
            offset: Offset(0, -6),
          ),
        ],
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 12,
            sigmaY: 12,
          ),
          child: Container(
            color: const Color(0xE6FFFFFF),
            child: SafeArea(
              top: false,
              child: SizedBox(
                height: 80,
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  currentIndex: currentIndex,
                  onTap: onTap,
                  selectedItemColor: const Color(0xFF032217),
                  unselectedItemColor: const Color(0xFF727974),
                  selectedFontSize: 11,
                  unselectedFontSize: 11,
                  selectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    height: 1.4,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                  showUnselectedLabels: true,
                  items: [
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.local_cafe_outlined),
                      activeIcon: Icon(Icons.local_cafe),
                      label: 'Beranda',
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.grid_view_rounded),
                      activeIcon: Icon(Icons.grid_view_rounded),
                      label: 'Menu',
                    ),
                    BottomNavigationBarItem(
                      icon: _buildCartIcon(totalItems),
                      activeIcon: _buildCartIcon(
                        totalItems,
                        active: true,
                      ),
                      label: 'Keranjang',
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.pending_actions_outlined),
                      activeIcon: Icon(Icons.pending_actions),
                      label: 'Pesanan',
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline),
                      activeIcon: Icon(Icons.person),
                      label: 'Profil',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCartIcon(
    int totalItems, {
    bool active = false,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(
          active
              ? Icons.shopping_bag
              : Icons.shopping_bag_outlined,
        ),
        if (totalItems > 0)
          Positioned(
            right: -8,
            top: -6,
            child: Container(
              padding: const EdgeInsets.all(2),
              constraints: const BoxConstraints(
                minWidth: 15,
                minHeight: 15,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF845326),
                shape: BoxShape.circle,
              ),
              child: Text(
                totalItems > 99 ? '99+' : '$totalItems',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
