
import 'package:flutter/material.dart';
import 'package:karasko_mobile_project/features/customer/home/screens/home_screen.dart';

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

  bool _isProcessing = true;

  @override
  void initState() {
    super.initState();
    _startPaymentSimulation();
  }

  Future<void> _startPaymentSimulation() async {
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() {
      _isProcessing = false;
    });
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
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: _isProcessing
                ? _buildProcessing()
                : _buildCompleted(),
          ),
        ),
      ),
    );
  }

  Widget _buildProcessing() {
    return Column(
      key: const ValueKey('processing'),
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
        _buildPaymentMethod(),
      ],
    );
  }

  Widget _buildCompleted() {
    return Column(
      key: const ValueKey('completed'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 76,
          height: 76,
          decoration: BoxDecoration(
            color: forestGreen.withValues(alpha: 0.08),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check_circle_outline,
            size: 52,
            color: forestGreen,
          ),
        ),
        const SizedBox(height: 28),
        const Text(
          'Simulasi Selesai',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: forestGreen,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Proses simulasi pembayaran telah selesai.\nTidak ada transaksi uang sungguhan.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            height: 1.5,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 24),
        _buildPaymentMethod(),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: forestGreen,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Kembali ke Checkout'),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethod() {
    return Container(
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
    );
  }
}
