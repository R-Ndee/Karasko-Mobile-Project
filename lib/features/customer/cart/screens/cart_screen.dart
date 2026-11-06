
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/cart_provider.dart';
import '../../../../core/widgets/primary_button.dart';
import '../widgets/cart_item_card.dart';
import '../../checkout/screens/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  static const Color forestGreen = Color(0xFF032217);
  static const Color cream = Color(0xFFF9F9F7);
  static const Color charcoal = Color(0xFF292B28);
  static const Color caramel = Color(0xFF845326);

  final TextEditingController _noteController = TextEditingController();

  String _orderType = 'Pickup';
  bool _useEcoPackaging = true;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  String formatRupiah(int value) {
    final digits = value.toString();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        backgroundColor: cream,
        foregroundColor: charcoal,
        elevation: 0,
        title: const Text(
          'Keranjang Saya',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: charcoal,
          ),
        ),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.isEmpty) {
            return _buildEmptyCart();
          }

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                  children: [
                    _buildRoasteryHeader(),
                    const SizedBox(height: 20),
                    _buildOrderTypeSelector(),
                    const SizedBox(height: 20),
                    _buildSectionTitle(
                      'Pesanan Kamu',
                      '${cart.totalItems} item',
                    ),
                    const SizedBox(height: 12),
                    ...cart.items.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: CartItemCard(
                          item: item,
                          onIncrease: () {
                            cart.increaseQuantity(item.product.id);
                          },
                          onDecrease: () {
                            cart.decreaseQuantity(item.product.id);
                          },
                          onRemove: () {
                            cart.removeItem(item.product.id);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildNoteSection(),
                    const SizedBox(height: 20),
                    _buildEcoPackagingOption(),
                    const SizedBox(height: 20),
                    _buildGuaranteeNote(),
                  ],
                ),
              ),
              _buildBottomSummary(cart.totalItems, cart.totalPrice),
            ],
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
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: forestGreen.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 48,
                color: forestGreen,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Keranjang Masih Kosong',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: charcoal,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Yuk, pilih kopi favoritmu dan tambahkan ke keranjang.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoasteryHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: forestGreen,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.coffee,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'KARASKO ROASTERY',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Freshly brewed for you.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.local_cafe_outlined,
            color: Colors.white70,
          ),
        ],
      ),
    );
  }

  Widget _buildOrderTypeSelector() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          _buildOrderTypeButton(
            label: 'Pickup',
            icon: Icons.shopping_bag_outlined,
          ),
          _buildOrderTypeButton(
            label: 'Dine-in',
            icon: Icons.restaurant_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildOrderTypeButton({
    required String label,
    required IconData icon,
  }) {
    final isSelected = _orderType == label;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _orderType = label;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            color: isSelected ? forestGreen : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected ? Colors.white : charcoal,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : charcoal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, String trailing) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: charcoal,
          ),
        ),
        Text(
          trailing,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildNoteSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Catatan Pesanan',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: charcoal,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _noteController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Contoh: Mohon siapkan pesanan dengan baik...',
            hintStyle: const TextStyle(
              fontSize: 13,
              color: Colors.black38,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEcoPackagingOption() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF1E9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.eco_outlined,
              color: forestGreen,
              size: 23,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Eco-friendly Packaging',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: charcoal,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Dukung penggunaan kemasan ramah lingkungan.',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: _useEcoPackaging,
            activeTrackColor: forestGreen,
            onChanged: (value) {
              setState(() {
                _useEcoPackaging = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGuaranteeNote() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.verified_user_outlined,
          color: caramel,
          size: 20,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            'Karasko menjaga kualitas setiap pesanan agar '
            'kopi yang kamu nikmati tetap istimewa.',
            style: TextStyle(
              fontSize: 12,
              height: 1.5,
              color: charcoal.withValues(alpha: 0.7),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSummary(int totalItems, int totalPrice) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(22),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Item',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  '$totalItems item',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: charcoal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Subtotal',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  formatRupiah(totalPrice),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: forestGreen,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              label: 'Lanjut ke Checkout',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CheckoutScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
