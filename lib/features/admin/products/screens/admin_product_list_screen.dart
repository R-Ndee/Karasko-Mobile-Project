import 'package:flutter/material.dart';

class AdminProductListScreen extends StatelessWidget {
  const AdminProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Product List Screen'),
      ),
      body: const Center(
        child: Text(
          'Admin Product List Screen - NorthGrind',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
