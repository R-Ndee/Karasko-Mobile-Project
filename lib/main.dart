import 'package:flutter/material.dart';
import 'features/splash/screens/splash_screen.dart';

import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'providers/order_provider.dart';
import 'package:karasko_mobile_project/features/admin/orders/screens/admin_order_list_screen.dart';
import 'package:karasko_mobile_project/features/customer/menu/screens/menu_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Karasko',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF9F9F7),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF032217),
          primary: const Color(0xFF032217),
          secondary: const Color(0xFF845326),
          surface: const Color(0xFFF9F9F7),
        ),
      ),
      home: AdminOrderListScreen(),
    );
  }
}
