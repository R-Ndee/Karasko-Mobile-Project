import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product Screen'),
      ),
      body: const Center(
        child: Text(
          'Edit Product Screen - NorthGrind',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
