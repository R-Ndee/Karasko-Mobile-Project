
import 'package:flutter/material.dart';

import '../../../../core/constants/themes/color_constants.dart';
import '../../../../core/constants/themes/size_constants.dart';
import '../../../../core/constants/themes/typography_constants.dart';

class AdminProductListScreen extends StatefulWidget {
  const AdminProductListScreen({super.key});

  @override
  State<AdminProductListScreen> createState() =>
      _AdminProductListScreenState();
}

class _AdminProductListScreenState extends State<AdminProductListScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedCategory = 'Semua';

  final List<String> _categories = [
    'Semua',
    'Coffee',
    'Non-Coffee',
    'Food',
  ];

  final List<_AdminProduct> _products = [
    _AdminProduct(
      name: 'Karasko Signature',
      category: 'Coffee',
      price: 25000,
      stock: 24,
      icon: Icons.coffee_rounded,
    ),
    _AdminProduct(
      name: 'Caramel Latte',
      category: 'Coffee',
      price: 30000,
      stock: 18,
      icon: Icons.local_cafe_rounded,
    ),
    _AdminProduct(
      name: 'Classic Americano',
      category: 'Coffee',
      price: 22000,
      stock: 32,
      icon: Icons.coffee_maker_rounded,
    ),
    _AdminProduct(
      name: 'Matcha Latte',
      category: 'Non-Coffee',
      price: 28000,
      stock: 15,
      icon: Icons.local_drink_rounded,
    ),
    _AdminProduct(
      name: 'Chocolate Frappe',
      category: 'Non-Coffee',
      price: 32000,
      stock: 12,
      icon: Icons.icecream_rounded,
    ),
    _AdminProduct(
      name: 'Butter Croissant',
      category: 'Food',
      price: 18000,
      stock: 20,
      icon: Icons.bakery_dining_rounded,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_AdminProduct> get _filteredProducts {
    final keyword = _searchController.text.toLowerCase().trim();

    return _products.where((product) {
      final matchesSearch = product.name.toLowerCase().contains(keyword);
      final matchesCategory = _selectedCategory == 'Semua' ||
          product.category == _selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  void _showIntegrationMessage(String feature) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$feature akan dihubungkan oleh Orang 2.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  String _formatPrice(int price) {
    final value = price.toString();
    final formatted = value.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    );

    return 'Rp$formatted';
  }

  @override
  Widget build(BuildContext context) {
    final products = _filteredProducts;

    return Scaffold(
      backgroundColor: BaseColor.cream,
      appBar: AppBar(
        backgroundColor: BaseColor.cream,
        surfaceTintColor: BaseColor.transparent,
        elevation: 0,
        title: Text(
          'Daftar Produk',
          style: BaseTypography.titleLarge.copyWith(
            color: BaseColor.charcoal,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(BaseSize.s20),
                children: [
                  Text(
                    'Kelola Produk',
                    style: BaseTypography.headlineSmall.copyWith(
                      color: BaseColor.charcoal,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Gap.h4,
                  Text(
                    'Pantau dan kelola produk Karasko.',
                    style: BaseTypography.bodyMedium.copyWith(
                      color: BaseColor.charcoal.withValues(alpha: 0.6),
                    ),
                  ),
                  Gap.h20,
                  _buildProductSummary(),
                  Gap.h24,
                  _buildSearchField(),
                  Gap.h16,
                  _buildCategoryFilter(),
                  Gap.h24,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Semua Produk',
                        style: BaseTypography.titleMedium.copyWith(
                          color: BaseColor.charcoal,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        '${products.length} produk',
                        style: BaseTypography.bodySmall.copyWith(
                          color: BaseColor.charcoal.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                  Gap.h16,
                  if (products.isEmpty)
                    _buildEmptyState()
                  else
                    ...products.map(_buildProductCard),
                  Gap.h16,
                  _buildAddButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductSummary() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(BaseSize.s20),
      decoration: BoxDecoration(
        color: BaseColor.karasko,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: BaseColor.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.inventory_2_outlined,
              color: BaseColor.white,
              size: 25,
            ),
          ),
          Gap.w16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Produk',
                  style: BaseTypography.bodySmall.copyWith(
                    color: BaseColor.white.withValues(alpha: 0.75),
                  ),
                ),
                Gap.h4,
                Text(
                  '${_products.length} Produk',
                  style: BaseTypography.titleLarge.copyWith(
                    color: BaseColor.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.trending_up_rounded,
            color: Color(0xFFD8C09E),
            size: 28,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      onChanged: (_) => setState(() {}),
      style: BaseTypography.bodyMedium.copyWith(
        color: BaseColor.charcoal,
      ),
      decoration: InputDecoration(
        hintText: 'Cari nama produk...',
        hintStyle: BaseTypography.bodyMedium.copyWith(
          color: BaseColor.charcoal.withValues(alpha: 0.4),
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: BaseColor.karasko,
        ),
        filled: true,
        fillColor: BaseColor.white,
        contentPadding: EdgeInsets.symmetric(
          vertical: BaseSize.s16,
          horizontal: BaseSize.s16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFFECEDE8),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: BaseColor.karasko,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _categories.map((category) {
          final isSelected = _selectedCategory == category;

          return Padding(
            padding: EdgeInsets.only(right: BaseSize.s8),
            child: ChoiceChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (_) {
                setState(() {
                  _selectedCategory = category;
                });
              },
              showCheckmark: false,
              selectedColor: BaseColor.karasko,
              backgroundColor: BaseColor.white,
              labelStyle: BaseTypography.labelMedium.copyWith(
                color: isSelected ? BaseColor.white : BaseColor.charcoal,
                fontWeight: FontWeight.w600,
              ),
              side: BorderSide(
                color: isSelected
                    ? BaseColor.karasko
                    : const Color(0xFFE6E8E2),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProductCard(_AdminProduct product) {
    return Container(
      margin: EdgeInsets.only(bottom: BaseSize.s12),
      padding: EdgeInsets.all(BaseSize.s12),
      decoration: BoxDecoration(
        color: BaseColor.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFECEDE8),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              color: const Color(0xFFECEFE8),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              product.icon,
              color: BaseColor.karasko,
              size: 32,
            ),
          ),
          Gap.w12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: BaseTypography.titleSmall.copyWith(
                    color: BaseColor.charcoal,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gap.h4,
                Text(
                  product.category,
                  style: BaseTypography.bodySmall.copyWith(
                    color: BaseColor.charcoal.withValues(alpha: 0.55),
                  ),
                ),
                Gap.h8,
                Text(
                  _formatPrice(product.price),
                  style: BaseTypography.titleSmall.copyWith(
                    color: BaseColor.caramel,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Gap.h4,
                Text(
                  'Stok: ${product.stock}',
                  style: BaseTypography.bodySmall.copyWith(
                    color: BaseColor.charcoal.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                tooltip: 'Edit produk',
                onPressed: () => _showIntegrationMessage('Edit produk'),
                icon: const Icon(
                  Icons.edit_outlined,
                  color: BaseColor.caramel,
                  size: 21,
                ),
              ),
              IconButton(
                tooltip: 'Hapus produk',
                onPressed: () => _showIntegrationMessage('Hapus produk'),
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: Color(0xFFB44B42),
                  size: 21,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: BaseSize.s40,
        horizontal: BaseSize.s20,
      ),
      child: Column(
        children: [
          const Icon(
            Icons.inventory_2_outlined,
            size: 48,
            color: BaseColor.caramel,
          ),
          Gap.h12,
          Text(
            'Produk tidak ditemukan',
            style: BaseTypography.titleMedium.copyWith(
              color: BaseColor.charcoal,
              fontWeight: FontWeight.w700,
            ),
          ),
          Gap.h4,
          Text(
            'Coba gunakan kata kunci atau kategori lain.',
            textAlign: TextAlign.center,
            style: BaseTypography.bodySmall.copyWith(
              color: BaseColor.charcoal.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton.icon(
        onPressed: () => _showIntegrationMessage('Tambah produk'),
        icon: const Icon(Icons.add_rounded),
        label: Text(
          'Tambah Produk',
          style: BaseTypography.labelLarge.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: BaseColor.karasko,
          foregroundColor: BaseColor.white,
          elevation: 0,
          shape: const StadiumBorder(),
        ),
      ),
    );
  }
}

class _AdminProduct {
  final String name;
  final String category;
  final int price;
  final int stock;
  final IconData icon;

  const _AdminProduct({
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    required this.icon,
  });
}