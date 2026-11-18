import 'package:flutter/material.dart';
import 'payment_success_screen.dart';

class PaymentScreen extends StatefulWidget {
  final String paymentMethod;

  const PaymentScreen({
    super.key,
    required this.paymentMethod,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  static const Color forestGreen = Color(0xFF032217);
  static const Color cream = Color(0xFFF9F9F7);
  static const Color caramel = Color(0xFF845326);

  @override
  void initState() {
    super.initState();
    _startPaymentSimulation();
  }

  Future<void> _startPaymentSimulation() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Otomatis pindah ke halaman PaymentSuccessScreen sambil membawa data paymentMethod
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentSuccessScreen(
          paymentMethod: widget.paymentMethod,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        backgroundColor: cream,
        foregroundColor: forestGreen,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Pembayaran',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: forestGreen,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 68,
                height: 68,
                child: CircularProgressIndicator(
                  color: forestGreen,
                  strokeWidth: 5,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Memproses Pembayaran',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: forestGreen,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Mohon tunggu sebentar.\nPembayaran kamu sedang diproses.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.payment,
                      color: caramel,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        widget.paymentMethod,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: forestGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}