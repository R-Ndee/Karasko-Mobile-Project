import 'package:flutter/material.dart';

class AdminOrderListScreen extends StatelessWidget {
  const AdminOrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Order List Screen'),
      ),
      body: const Center(
        child: Text(
          'Admin Order List Screen - NorthGrind',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
