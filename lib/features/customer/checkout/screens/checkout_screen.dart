
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/primary_button.dart';
import '../../../../providers/cart_provider.dart';
import '../../payment/screens/payment_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  static const Color forestGreen = Color(0xFF032217);
  static const Color cream = Color(0xFFF9F9F7);
  static const Color charcoal = Color(0xFF292B28);
  static const Color caramel = Color(0xFF845326);

  String _paymentMethod = 'QRIS';
  String _selectedBank = 'BCA';

  final TextEditingController _noteController = TextEditingController();

  final List<String> _banks = ['BCA', 'Mandiri', 'BRI'];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  String _formatRupiah(int amount) {
    final digits = amount.toString();
    final buffer = StringBuffer();

    for (int i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);

      final remaining = digits.length - i - 1;

      if (remaining > 0 && remaining % 3 == 0) {
        buffer.write('.');
      }
    }

    return 'Rp $buffer';
  }

  String get _paymentMethodLabel {
    switch (_paymentMethod) {
      case 'QRIS':
        return 'QRIS Barista Mock';
      case 'Virtual Account':
        return 'Virtual Account - $_selectedBank';
      case 'Tunai':
        return 'Tunai di Meja Kasir';
      default:
        return _paymentMethod;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        backgroundColor: cream,
        foregroundColor: forestGreen,
        elevation: 0,
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: forestGreen,
          ),
        ),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.isEmpty) {
            return _buildEmptyCart();
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Ringkasan Pesanan'),
                const SizedBox(height: 14),
                ...cart.items.map(_buildProductItem),
                const SizedBox(height: 28),
                _buildSectionTitle('Catatan Pesanan'),
                const SizedBox(height: 12),
                _buildNoteField(),
                const SizedBox(height: 28),
                _buildSectionTitle('Metode Pembayaran'),
                const SizedBox(height: 14),
                _buildPaymentOption(
                  title: 'QRIS',
                  subtitle: 'QRIS Barista Mock',
                  icon: Icons.qr_code_2,
                ),
                _buildPaymentOption(
                  title: 'Virtual Account',
                  subtitle: 'BCA, Mandiri, atau BRI',
                  icon: Icons.account_balance,
                ),
                if (_paymentMethod == 'Virtual Account')
                  _buildBankSelector(),
                _buildPaymentOption(
                  title: 'Tunai',
                  subtitle: 'Bayar langsung di meja kasir',
                  icon: Icons.payments_outlined,
                ),
                const SizedBox(height: 28),
                _buildPaymentSummary(cart.totalPrice),
                const SizedBox(height: 24),
                _buildSecurityNote(),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.isEmpty) {
            return const SizedBox.shrink();
          }

          return Container(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Pembayaran',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatRupiah(cart.totalPrice),
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: forestGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: PrimaryButton(
                      label: 'Lanjutkan',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PaymentScreen(
                              paymentMethod: _paymentMethodLabel,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_bag_outlined,
              size: 64,
              color: caramel,
            ),
            const SizedBox(height: 16),
            const Text(
              'Keranjang masih kosong',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: forestGreen,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tambahkan produk terlebih dahulu sebelum checkout.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Kembali ke Keranjang'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: forestGreen,
      ),
    );
  }

  Widget _buildProductItem(dynamic item) {
    final imageUrl = item.product.imageUrl;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 66,
            height: 76,
            decoration: BoxDecoration(
              color: cream,
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.antiAlias,
            child: imageUrl != null && imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.coffee,
                        size: 30,
                        color: caramel,
                      );
                    },
                  )
                : const Icon(
                    Icons.coffee,
                    size: 30,
                    color: caramel,
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: charcoal,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${item.quantity} x ${_formatRupiah(item.product.price)}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            _formatRupiah(item.subtotal),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: forestGreen,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteField() {
    return TextField(
      controller: _noteController,
      maxLines: 3,
      maxLength: 150,
      decoration: InputDecoration(
        hintText: 'Contoh: Kurangi gula, tanpa sedotan...',
        hintStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black38,
        ),
        filled: true,
        fillColor: Colors.white,
        counterStyle: const TextStyle(fontSize: 10),
        contentPadding: const EdgeInsets.all(14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final isSelected = _paymentMethod == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          _paymentMethod = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? forestGreen : Colors.black12,
            width: isSelected ? 1.3 : 0.7,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: forestGreen, size: 23),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title == 'QRIS'
                        ? 'QRIS Barista Mock'
                        : title == 'Virtual Account'
                            ? 'Virtual Account Simulasi'
                            : 'Tunai di Meja Kasir',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: charcoal,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: isSelected ? forestGreen : Colors.black38,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBankSelector() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: forestGreen.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Text(
            'Pilih Bank',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: forestGreen,
            ),
          ),
          const Spacer(),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedBank,
              items: _banks.map((bank) {
                return DropdownMenuItem(
                  value: bank,
                  child: Text(
                    bank,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedBank = value;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSummary(int subtotal) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Subtotal',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              Text(
                _formatRupiah(subtotal),
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(height: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Pembayaran',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: charcoal,
                ),
              ),
              Text(
                _formatRupiah(subtotal),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: forestGreen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityNote() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.verified_user_outlined,
          size: 18,
          color: caramel,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            'Pesanan Karasko diproses dengan simulasi pembayaran untuk keperluan demonstrasi aplikasi.',
            style: TextStyle(
              fontSize: 10,
              height: 1.5,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ],
    );
  }
}
