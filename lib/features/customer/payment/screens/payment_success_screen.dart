
import 'package:flutter/material.dart';

import '../../navigation/customer_navigation.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final String paymentMethod;

  const PaymentSuccessScreen({
    super.key,
    required this.paymentMethod,
  });

  static const Color forestGreen = Color(0xFF032217);
  static const Color cream = Color(0xFFF9F9F7);
  static const Color caramel = Color(0xFF845326);
  static const Color charcoal = Color(0xFF292B28);

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
          'Status Pembayaran',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: forestGreen,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    color: forestGreen.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_outline,
                    size: 56,
                    color: forestGreen,
                  ),
                ),
                const SizedBox(height: 28),
                const Text(
                  'Pembayaran Berhasil!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: forestGreen,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Simulasi pembayaran berhasil diselesaikan. '
                  'Pesananmu telah diterima oleh kedai dan '
                  'akan segera diproses oleh barista.',
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
                          paymentMethod,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: forestGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF4E8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 18,
                        color: caramel,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Ini merupakan simulasi pembayaran untuk '
                          'demonstrasi aplikasi. Tidak ada transaksi '
                          'atau pemotongan uang sungguhan.',
                          style: TextStyle(
                            fontSize: 11,
                            height: 1.5,
                            color: charcoal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 36),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const CustomerNavigation(),
                        ),
                        (route) => false,
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
                    child: const Text(
                      'Kembali ke Beranda',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
