import 'package:flutter/material.dart';

class ActiveOrderScreen extends StatelessWidget {
  const ActiveOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Order Screen'),
      ),
      body: const Center(
        child: Text(
          'Active Order Screen - NorthGrind',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
