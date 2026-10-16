import 'package:flutter/material.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Success Screen'),
      ),
      body: const Center(
        child: Text(
          'Payment Success Screen - NorthGrind',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
