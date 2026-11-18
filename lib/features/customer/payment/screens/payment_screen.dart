
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/cart_item.dart';
import '../../../../models/order_model.dart';
import '../../../../providers/cart_provider.dart';
import '../../../../providers/order_provider.dart';
import 'payment_success_screen.dart';

class PaymentScreen extends StatefulWidget {
  final String paymentMethod;
  final String orderType;
  final bool useEcoPackaging;
  final String orderNote;

  const PaymentScreen({
    super.key,
    required this.paymentMethod,
    required this.orderType,
    required this.useEcoPackaging,
    required this.orderNote,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  static const Color forestGreen = Color(0xFF032217);
  static const Color cream = Color(0xFFF9F9F7);
  static const Color charcoal = Color(0xFF292B28);
  static const Color caramel = Color(0xFF845326);

  bool _isProcessing = true;
  bool _hasError = false;

  String? _orderId;

  @override
  void initState() {
    super.initState();
    _processPayment();
  }

  Future<void> _processPayment() async {
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    final cart = context.read<CartProvider>();
    final items = List<CartItem>.from(cart.items);

    if (items.isEmpty) {
      setState(() {
        _isProcessing = false;
        _hasError = true;
      });
      return;
    }

    final order = OrderModel(
      id: 'KRS-${DateTime.now().millisecondsSinceEpoch}',
      items: items,
      totalPrice: cart.totalPrice,
      paymentMethod: widget.paymentMethod,
      status: 'Diterima',
      createdAt: DateTime.now(),
      orderType: widget.orderType,
      useEcoPackaging: widget.useEcoPackaging,
      orderNote: widget.orderNote,
    );

    context.read<OrderProvider>().addOrder(order);

    cart.clearCart();

    setState(() {
      _orderId = order.id;
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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: _isProcessing
                  ? _buildProcessingState()
                  : _hasError
                      ? _buildErrorState()
                      : _buildCompletedState(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProcessingState() {
    return Column(
      key: const ValueKey('processing'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 108,
          height: 108,
          decoration: BoxDecoration(
            color: forestGreen.withValues(alpha: 0.08),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: SizedBox(
              width: 42,
              height: 42,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: forestGreen,
              ),
            ),
          ),
        ),
        const SizedBox(height: 28),
        const Text(
          'Memproses Pembayaran',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: forestGreen,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Mohon tunggu sebentar. Kami sedang memproses '
          'simulasi pembayaran pesanan kamu.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            height: 1.6,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 24),
        _buildPaymentInformation(),
      ],
    );
  }

  Widget _buildCompletedState() {
    return Column(
      key: const ValueKey('completed'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 108,
          height: 108,
          decoration: BoxDecoration(
            color: forestGreen.withValues(alpha: 0.09),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check_circle_rounded,
            size: 66,
            color: forestGreen,
          ),
        ),
        const SizedBox(height: 28),
        const Text(
          'Simulasi Selesai',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: forestGreen,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Simulasi pembayaran berhasil diselesaikan. '
          'Terima kasih telah memesan di Karasko.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            height: 1.6,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 24),
        _buildPaymentInformation(),
        const SizedBox(height: 28),
        if (_orderId != null)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: forestGreen.withValues(alpha: 0.12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nomor Pesanan',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  _orderId!,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: forestGreen,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 20),
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
                  'Ini hanya simulasi untuk demonstrasi aplikasi. '
                  'Tidak ada transaksi atau pemotongan uang sungguhan.',
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
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: _returnToHome,
            style: ElevatedButton.styleFrom(
              backgroundColor: forestGreen,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Kembali ke Beranda',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState() {
    return Column(
      key: const ValueKey('error'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 108,
          height: 108,
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.08),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.error_outline_rounded,
            size: 62,
            color: Colors.redAccent,
          ),
        ),
        const SizedBox(height: 28),
        const Text(
          'Pesanan Tidak Ditemukan',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: forestGreen,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Keranjang kamu kosong. Tidak ada pesanan '
          'yang dapat diproses.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            height: 1.6,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: forestGreen,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Kembali',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentInformation() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          _buildInfoRow('Metode Pembayaran', widget.paymentMethod),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1),
          ),
          _buildInfoRow('Jenis Pesanan', widget.orderType),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1),
          ),
          _buildInfoRow(
            'Eco Packaging',
            widget.useEcoPackaging ? 'Aktif' : 'Tidak aktif',
          ),
          if (widget.orderNote.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 1),
            ),
            _buildInfoRow('Catatan', widget.orderNote),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: charcoal,
            ),
          ),
        ),
      ],
    );
  }

  void _returnToHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentSuccessScreen(
          paymentMethod: widget.paymentMethod,
        ),
      ),
      (route) => false,
    );
  }
}
