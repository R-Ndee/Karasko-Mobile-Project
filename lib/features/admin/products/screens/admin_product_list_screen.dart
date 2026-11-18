import 'package:flutter/material.dart';

import '../../../../core/constants/themes/color_constants.dart';
import '../../../../core/constants/themes/size_constants.dart';
import '../../../../core/constants/themes/typography_constants.dart';
import '../models/admin_product.dart';
import '../widgets/delete_product_dialog.dart';
import 'add_product_screen.dart';
import 'edit_product_screen.dart';

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

  final List<AdminProduct> _products = [
    const AdminProduct(
      name: 'Karasko Signature',
      category: 'Coffee',
      price: 25000,
      stock: 24,
      icon: Icons.coffee_rounded,
    ),
    const AdminProduct(
      name: 'Caramel Latte',
      category: 'Coffee',
      price: 30000,
      stock: 18,
      icon: Icons.local_cafe_rounded,
    ),
    const AdminProduct(
      name: 'Classic Americano',
      category: 'Coffee',
      price: 22000,
      stock: 32,
      icon: Icons.coffee_maker_rounded,
    ),
    const AdminProduct(
      name: 'Matcha Latte',
      category: 'Non-Coffee',
      price: 28000,
      stock: 15,
      icon: Icons.local_drink_rounded,
    ),
    const AdminProduct(
      name: 'Chocolate Frappe',
      category: 'Non-Coffee',
      price: 32000,
      stock: 12,
      icon: Icons.icecream_rounded,
    ),
    const AdminProduct(
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

  List<AdminProduct> get _filteredProducts {
    final keyword = _searchController.text.toLowerCase().trim();

    return _products.where((product) {
      final matchesSearch = product.name.toLowerCase().contains(keyword);
      final matchesCategory = _selectedCategory == 'Semua' ||
          product.category == _selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  int _categoryCount(String category) {
    if (category == 'Semua') return _products.length;

    return _products.where((product) => product.category == category).length;
  }

  void _showIntegrationMessage(String feature) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: BaseColor.karasko,
        ),
      );
  }

  Future<void> _openAddProduct() async {
    final newProduct = await Navigator.push<AdminProduct>(
      context,
      MaterialPageRoute(
        builder: (_) => const AddProductScreen(),
      ),
    );

    if (newProduct != null && mounted) {
      setState(() {
        _products.insert(0, newProduct);
      });
      _showFeedback('${newProduct.name} berhasil ditambahkan');
    }
  }

  Future<void> _openEditProduct(AdminProduct product) async {
    final updatedProduct = await Navigator.push<AdminProduct>(
      context,
      MaterialPageRoute(
        builder: (_) => EditProductScreen(product: product),
      ),
    );

    if (updatedProduct != null && mounted) {
      setState(() {
        final index = _products.indexOf(product);
        if (index != -1) {
          _products[index] = updatedProduct;
        }
      });
      _showFeedback('${updatedProduct.name} berhasil diperbarui');
    }
  }

  Future<void> _confirmDeleteProduct(AdminProduct product) async {
    final isConfirmed = await DeleteProductDialog.show(context, product);

    if (isConfirmed == true && mounted) {
      setState(() {
        _products.remove(product);
      });
      _showFeedback('${product.name} telah dihapus');
    }
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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      BaseSize.s20,
                      BaseSize.s20,
                      BaseSize.s20,
                      BaseSize.s32,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        _buildHeader(),
                        Gap.h24,
                        _buildProductSummary(),
                        Gap.h24,
                        _buildSearchField(),
                        Gap.h18,
                        _buildCategoryFilter(),
                        Gap.h24,
                        _buildProductHeading(products.length),
                        Gap.h14,
                        if (products.isEmpty)
                          _buildEmptyState()
                        else
                          ...products.map(_buildProductCard),
                        Gap.h12,
                        _buildAddButton(),
                        Gap.h12,
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: BaseColor.karasko,
                borderRadius: BorderRadius.circular(11),
              ),
              child: const Icon(
                Icons.coffee_rounded,
                color: BaseColor.white,
                size: 19,
              ),
            ),
            Gap.w10,
            Text(
              'KARASKO ADMIN',
              style: BaseTypography.labelSmall.copyWith(
                color: BaseColor.caramel,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.4,
              ),
            ),
          ],
        ),
        Gap.h20,
        Text(
          'Manajemen Produk',
          style: BaseTypography.displaySmall.copyWith(
            fontSize: 27,
            fontWeight: FontWeight.w700,
          ),
        ),
        Gap.h6,
        Text(
          'Kelola katalog dan pantau ketersediaan produk.',
          style: BaseTypography.bodySmall.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildProductSummary() {
    final coffeeCount = _categoryCount('Coffee');
    final nonCoffeeCount = _categoryCount('Non-Coffee');
    final foodCount = _categoryCount('Food');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(BaseSize.s20),
      decoration: BoxDecoration(
        color: BaseColor.karasko,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: BaseColor.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.inventory_2_outlined,
                  color: BaseColor.white,
                  size: 23,
                ),
              ),
              Gap.w14,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TOTAL PRODUK',
                      style: BaseTypography.labelSmall.copyWith(
                        color: BaseColor.white.withValues(alpha: 0.7),
                        letterSpacing: 1.1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gap.h4,
                    Text(
                      '${_products.length} Produk',
                      style: BaseTypography.headlineMedium.copyWith(
                        color: BaseColor.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.trending_up_rounded,
                color: Color(0xFFD8C09E),
                size: 26,
              ),
            ],
          ),
          Gap.h20,
          Container(
            height: 1,
            color: BaseColor.white.withValues(alpha: 0.15),
          ),
          Gap.h14,
          Row(
            children: [
              Expanded(
                child: _SummaryCategory(
                  label: 'Coffee',
                  count: coffeeCount,
                ),
              ),
              Expanded(
                child: _SummaryCategory(
                  label: 'Non-Coffee',
                  count: nonCoffeeCount,
                ),
              ),
              Expanded(
                child: _SummaryCategory(
                  label: 'Food',
                  count: foodCount,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: BaseColor.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: BaseColor.charcoal.withValues(alpha: 0.08),
        ),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (_) => setState(() {}),
        style: BaseTypography.bodyMedium,
        decoration: InputDecoration(
          hintText: 'Cari nama produk...',
          hintStyle: BaseTypography.bodyMedium.copyWith(
            color: Colors.grey.shade400,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: BaseColor.karasko,
            size: 22,
          ),
          suffixIcon: _searchController.text.isEmpty
              ? null
              : IconButton(
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    size: 19,
                    color: Colors.grey,
                  ),
                ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: BaseSize.s16,
            vertical: BaseSize.s16,
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
          final count = _categoryCount(category);

          return Padding(
            padding: const EdgeInsets.only(right: BaseSize.s8),
            child: ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(category),
                  Gap.w6,
                  Text(
                    '$count',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: isSelected
                          ? BaseColor.white.withValues(alpha: 0.8)
                          : BaseColor.charcoal.withValues(alpha: 0.55),
                    ),
                  ),
                ],
              ),
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
                    : BaseColor.charcoal.withValues(alpha: 0.09),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: BaseSize.s10,
                vertical: BaseSize.s6,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProductHeading(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _selectedCategory == 'Semua'
              ? 'Semua Produk'
              : _selectedCategory,
          style: BaseTypography.headlineSmall.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: BaseSize.s10,
            vertical: BaseSize.s6,
          ),
          decoration: BoxDecoration(
            color: BaseColor.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '$count produk',
            style: BaseTypography.labelSmall.copyWith(
              color: BaseColor.charcoal.withValues(alpha: 0.65),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(_AdminProduct product) {
    final stockColor = product.stock <= 10
        ? const Color(0xFFB44B42)
        : product.stock <= 15
            ? const Color(0xFFB7791F)
            : const Color(0xFF28734F);

    return Container(
      margin: const EdgeInsets.only(bottom: BaseSize.s12),
      padding: const EdgeInsets.all(BaseSize.s14),
      decoration: BoxDecoration(
        color: BaseColor.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: BaseColor.charcoal.withValues(alpha: 0.07),
        ),
        boxShadow: [
          BoxShadow(
            color: BaseColor.charcoal.withValues(alpha: 0.025),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          _ProductIcon(product: product),
          Gap.w14,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: BaseTypography.titleSmall.copyWith(
                    fontWeight: FontWeight.w700,
                    color: BaseColor.charcoal,
                  ),
                ),
                Gap.h4,
                Text(
                  product.category,
                  style: BaseTypography.bodySmall.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
                Gap.h8,
                Text(
                  _formatPrice(product.price),
                  style: BaseTypography.titleMedium.copyWith(
                    color: BaseColor.caramel,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Gap.h8,
                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: stockColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Gap.w6,
                    Text(
                      'Stok ${product.stock}',
                      style: BaseTypography.labelSmall.copyWith(
                        color: stockColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gap.w6,
                    Text(
                      product.stock <= 10
                          ? '• Rendah'
                          : product.stock <= 15
                              ? '• Terbatas'
                              : '• Tersedia',
                      style: BaseTypography.labelSmall.copyWith(
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Gap.w4,
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ProductActionButton(
                icon: Icons.edit_outlined,
                color: BaseColor.caramel,
                tooltip: 'Edit produk',
                onPressed: () => _showIntegrationMessage('Edit produk'),
              ),
              Gap.h8,
              _ProductActionButton(
                icon: Icons.delete_outline_rounded,
                color: const Color(0xFFB44B42),
                tooltip: 'Hapus produk',
                onPressed: () => _showIntegrationMessage('Hapus produk'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: BaseSize.s40,
        horizontal: BaseSize.s20,
      ),
      decoration: BoxDecoration(
        color: BaseColor.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: BaseColor.charcoal.withValues(alpha: 0.07),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: BaseColor.cream,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.inventory_2_outlined,
              size: 30,
              color: BaseColor.caramel,
            ),
          ),
          Gap.h14,
          Text(
            'Produk tidak ditemukan',
            style: BaseTypography.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Gap.h6,
          Text(
            'Coba gunakan kata kunci atau kategori lain.',
            textAlign: TextAlign.center,
            style: BaseTypography.bodySmall.copyWith(
              color: Colors.grey.shade600,
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
        icon: const Icon(Icons.add_rounded, size: 21),
        label: Text(
          'Tambah Produk',
          style: BaseTypography.labelLarge.copyWith(
            color: BaseColor.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: BaseColor.karasko,
          foregroundColor: BaseColor.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}

class _SummaryCategory extends StatelessWidget {
  final String label;
  final int count;

  const _SummaryCategory({
    required this.label,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$count',
          style: BaseTypography.titleLarge.copyWith(
            color: BaseColor.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        Gap.h2,
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: BaseTypography.labelSmall.copyWith(
            color: BaseColor.white.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}

class _ProductIcon extends StatelessWidget {
  final _AdminProduct product;

  const _ProductIcon({required this.product});

  @override
  Widget build(BuildContext context) {
    final Color background;
    final Color foreground;

    switch (product.category) {
      case 'Non-Coffee':
        background = const Color(0xFFE9EFE5);
        foreground = const Color(0xFF55734B);
      case 'Food':
        background = const Color(0xFFF5EBDD);
        foreground = BaseColor.caramel;
      default:
        background = const Color(0xFFE8EEE9);
        foreground = BaseColor.karasko;
    }

    return Container(
      width: 66,
      height: 66,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        product.icon,
        color: foreground,
        size: 30,
      ),
    );
  }
}

class _ProductActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String tooltip;
  final VoidCallback onPressed;

  const _ProductActionButton({
    required this.icon,
    required this.color,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      constraints: const BoxConstraints(
        minWidth: 36,
        minHeight: 36,
      ),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      style: IconButton.styleFrom(
        backgroundColor: color.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11),
        ),
      ),
      icon: Icon(
        icon,
        color: color,
        size: 19,
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
