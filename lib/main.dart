import 'package:flutter/material.dart';
import 'package:karasko_mobile_project/features/admin/orders/screens/admin_order_list_screen.dart';
import 'package:karasko_mobile_project/features/customer/menu/screens/menu_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AdminOrderListScreen(),
    );
  }
}
