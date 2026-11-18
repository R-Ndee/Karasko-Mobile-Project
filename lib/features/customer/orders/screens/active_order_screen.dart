import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/order_provider.dart';

class ActiveOrderScreen extends StatefulWidget {
  const ActiveOrderScreen({super.key});

  @override
  State<ActiveOrderScreen> createState() => _ActiveOrderScreenState();
}

class _ActiveOrderScreenState extends State<ActiveOrderScreen> {
  // Palet Warna Karasko
  static const Color forestGreen = Color(0xFF032217);
  static const Color lightGreen = Color(0xFF81A291);
  static const Color cream = Color(0xFFF9F9F7);
  static const Color charcoal = Color(0xFF292B28);
  static const Color caramel = Color(0xFF845326);

  // ===========================================================================
  // SAKELAR MOCK DATA (DATA DUMMY)
  // Ubah ke `true` untuk melihat tampilan ADA PESANAN
  // Ubah ke `false` untuk melihat tampilan KOSONG
  // ===========================================================================
  bool showMockOrder = true; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        backgroundColor: cream,
        elevation: 0,
        foregroundColor: charcoal,
        title: const Text(
          'Pesanan Aktif',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: charcoal,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              showMockOrder ? Icons.visibility_off : Icons.visibility,
              color: forestGreen,
            ),
            tooltip: 'Simulasi Kosong / Ada Isi',
            onPressed: () {
              setState(() {
                showMockOrder = !showMockOrder;
              });
            },
          ),
        ],
      ),
      body: showMockOrder ? _buildActiveOrders() : _buildEmptyOrders(),
    );
  }

  // ===========================================================================
  // 1. TAMPILAN JIKA BELUM ADA PESANAN AKTIF (KOSONG)
  // ===========================================================================
  Widget _buildEmptyOrders() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: forestGreen.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.pending_actions_outlined,
                size: 48,
                color: forestGreen,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Belum Ada Pesanan Aktif',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: charcoal,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Kopi racikan favoritmu yang sedang diseduh atau siap diambil akan muncul di sini.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 2. TAMPILAN JIKA ADA PESANAN AKTIF
  // ===========================================================================
  Widget _buildActiveOrders() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: forestGreen,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NO. PESANAN',
                          style: TextStyle(
                            color: lightGreen,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '#NG-8492',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: caramel.withOpacity(0.2),
                        border: Border.all(color: caramel),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Pickup • Kedai',
                        style: TextStyle(
                          color: Color(0xFFF4D4B8),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status Stepper Progress
                    _buildStatusTimeline(currentStep: 1),
                    
                    const Divider(height: 32, thickness: 1),

                    // Detail Item Pesanan
                    const Text(
                      'Rincian Menu',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: charcoal,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildOrderItemTile(
                      name: 'Flat White Oatmilk',
                      notes: 'Less Sugar, Extra Shot',
                      price: 'Rp 38.000',
                      quantity: 1,
                    ),
                    const SizedBox(height: 8),
                    _buildOrderItemTile(
                      name: 'Butter Croissant',
                      notes: 'Warmed',
                      price: 'Rp 24.000',
                      quantity: 1,
                    ),

                    const Divider(height: 32, thickness: 1),

                    // Total & Estimasi
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Estimasi Selesai',
                              style: TextStyle(fontSize: 12, color: Colors.black45),
                            ),
                            SizedBox(height: 2),
                            Text(
                              '10 - 15 Menit',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: caramel,
                              ),
                            ),
                          ],
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Total Pembayaran',
                              style: TextStyle(fontSize: 12, color: Colors.black45),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Rp 62.000',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: forestGreen,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Tombol Tunjukkan QR Code (Sudah Diperbaiki shape-nya)
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 46),
                        side: const BorderSide(color: forestGreen),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // TODO: Tampilkan Dialog QR Code Pengambilan
                      },
                      icon: const Icon(Icons.qr_code, color: forestGreen),
                      label: const Text(
                        'Tunjukkan Kode Pengambilan',
                        style: TextStyle(
                          color: forestGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget Status Bar Timeline
  Widget _buildStatusTimeline({required int currentStep}) {
    final steps = ['Diterima', 'Disiapkan', 'Siap Ambil'];

    return Row(
      children: List.generate(steps.length, (index) {
        final isActive = index <= currentStep;
        final isCurrent = index == currentStep;

        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: isActive ? forestGreen : Colors.grey.shade300,
                      child: Icon(
                        isCurrent
                            ? Icons.coffee
                            : (isActive ? Icons.check : Icons.circle_outlined),
                        size: 14,
                        color: isActive ? Colors.white : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      steps[index],
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                        color: isCurrent ? forestGreen : Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
              if (index < steps.length - 1)
                Expanded(
                  child: Container(
                    height: 2,
                    color: index < currentStep ? forestGreen : Colors.grey.shade300,
                    margin: const EdgeInsets.only(bottom: 18),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  // Widget Item List
  Widget _buildOrderItemTile({
    required String name,
    required String notes,
    required String price,
    required int quantity,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: cream,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '${quantity}x',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: forestGreen,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: charcoal,
                ),
              ),
              if (notes.isNotEmpty)
                Text(
                  notes,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black45,
                  ),
                ),
            ],
          ),
        ),
        Text(
          price,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: charcoal,
          ),
        ),
      ],
    );
  }
}