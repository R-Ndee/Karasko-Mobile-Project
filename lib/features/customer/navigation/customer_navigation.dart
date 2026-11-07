import 'package:flutter/material.dart';
import '../home/screens/home_screen.dart';
import '../profile/screens/profile_screen.dart';

class CustomerNavigation extends StatefulWidget {
  const CustomerNavigation({super.key});

  @override
  State<CustomerNavigation> createState() => _CustomerNavigationState();
}

class _CustomerNavigationState extends State<CustomerNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(), 
    const Center(child: Text('Halaman Menu')),
    const Center(child: Text('Halaman Keranjang')),
    const Center(child: Text('Halaman Pesanan Aktif')),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1A382B).withOpacity(0.06),
              blurRadius: 24,
              offset: const Offset(0, -6),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white.withOpacity(0.9),
          elevation: 0,
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF032217),
          unselectedItemColor: const Color(0xFF424844),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 11),
          onTap: _onItemTapped,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.local_cafe_outlined),
              activeIcon: Icon(Icons.local_cafe),
              label: 'Beranda',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.grid_view),
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  const Icon(Icons.shopping_bag_outlined),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Color(0xFF845326),
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                      child: const Text(
                        '2',
                        style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              activeIcon: const Icon(Icons.shopping_bag),
              label: 'Keranjang',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.pending_actions),
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
    );
  }
}