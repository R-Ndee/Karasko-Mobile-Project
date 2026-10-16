import 'package:flutter/material.dart';

class AdminOrderDetailScreen extends StatelessWidget {
  const AdminOrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Order Detail Screen'),
      ),
      body: const Center(
        child: Text(
          'Admin Order Detail Screen - NorthGrind',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
