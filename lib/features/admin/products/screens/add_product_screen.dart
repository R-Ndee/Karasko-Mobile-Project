import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/themes/color_constants.dart';
import '../../../../core/constants/themes/size_constants.dart';
import '../../../../core/constants/themes/typography_constants.dart';
import '../models/admin_product.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedCategory = 'Coffee';
  IconData _selectedIcon = Icons.coffee_rounded;

  final List<String> _categories = ['Coffee', 'Non-Coffee', 'Food'];

  final _iconOptions = [
    Icons.coffee_rounded,
    Icons.local_cafe_rounded,
    Icons.coffee_maker_rounded,
    Icons.local_drink_rounded,
    Icons.icecream_rounded,
    Icons.bakery_dining_rounded,
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final newProduct = AdminProduct(
      name: _nameController.text.trim(),
      category: _selectedCategory,
      price: int.parse(_priceController.text.trim()),
      stock: int.parse(_stockController.text.trim()),
      description: _descriptionController.text.trim(),
      icon: _selectedIcon,
    );

    Navigator.pop(context, newProduct);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColor.cream,
      appBar: AppBar(
        backgroundColor: BaseColor.cream,
        surfaceTintColor: BaseColor.transparent,
        elevation: 0,
        foregroundColor: BaseColor.charcoal,
        title: Text(
          'Tambah Produk',
          style: BaseTypography.titleLarge.copyWith(
            color: BaseColor.charcoal,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(BaseSize.s20),
          children: [
            Text(
              'Informasi Produk Baru',
              style: BaseTypography.headlineSmall.copyWith(
                color: BaseColor.charcoal,
                fontWeight: FontWeight.w800,
              ),
            ),
            Gap.h4,
            Text(
              'Lengkapi detail menu yang akan ditambahkan ke katalog Karasko.',
              style: BaseTypography.bodySmall.copyWith(
                color: BaseColor.charcoal.withValues(alpha: 0.6),
              ),
            ),
            Gap.h20,
            _buildIconSelector(),
            Gap.h20,
            _buildLabel('Nama Produk'),
            Gap.h8,
            TextFormField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              style: BaseTypography.bodyMedium,
              decoration: _inputDecoration(hint: 'Contoh: Karasko Palm Sugar'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama produk wajib diisi';
                }
                return null;
              },
            ),
            Gap.h20,
            _buildLabel('Kategori'),
            Gap.h8,
            Wrap(
              spacing: BaseSize.s8,
              children: _categories.map((category) {
                final isSelected = _selectedCategory == category;
                return ChoiceChip(
                  label: Text(category),
                  selected: isSelected,
                  showCheckmark: false,
                  onSelected: (_) {
                    setState(() => _selectedCategory = category);
                  },
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
                );
              }).toList(),
            ),
            Gap.h20,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Harga (Rp)'),
                      Gap.h8,
                      TextFormField(
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: BaseTypography.bodyMedium,
                        decoration: _inputDecoration(
                          hint: '25000',
                          prefixText: 'Rp ',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Harga wajib diisi';
                          }
                          if ((int.tryParse(value) ?? 0) <= 0) {
                            return 'Harga tidak valid';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Gap.w12,
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Stok Awal'),
                      Gap.h8,
                      TextFormField(
                        controller: _stockController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: BaseTypography.bodyMedium,
                        decoration: _inputDecoration(hint: '20'),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Stok wajib diisi';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap.h20,
            _buildLabel('Deskripsi Produk (Opsional)'),
            Gap.h8,
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              style: BaseTypography.bodyMedium,
              decoration: _inputDecoration(
                hint: 'Tuliskan cita rasa atau komposisi singkat produk...',
              ),
            ),
            Gap.h32,
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                onPressed: _submitForm,
                icon: const Icon(Icons.check_rounded),
                label: Text(
                  'Simpan Produk',
                  style: BaseTypography.labelLarge.copyWith(
                    color: BaseColor.white,
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
            ),
          ],
        ),
      ),
    );
  }

Widget _buildIconSelector() {
    return Container(
      padding: const EdgeInsets.all(BaseSize.s16),
      decoration: BoxDecoration(
        color: BaseColor.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFECEDE8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFECEFE8),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  _selectedIcon,
                  color: BaseColor.karasko,
                  size: 28,
                ),
              ),
              Gap.w12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ikon Tampilan Produk',
                      style: BaseTypography.titleSmall.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Gap.h4,
                    Text(
                      'Pilih ikon yang mewakili jenis menu ini.',
                      style: BaseTypography.bodySmall.copyWith(
                        color: BaseColor.charcoal.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap.h16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _iconOptions.map((iconData) {
              final isSelected = _selectedIcon == iconData;

              return GestureDetector(
                onTap: () => setState(() => _selectedIcon = iconData),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? BaseColor.karasko
                        : const Color(0xFFF4F5F1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    iconData,
                    size: 22,
                    color: isSelected ? BaseColor.white : BaseColor.charcoal,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: BaseTypography.titleSmall.copyWith(
        color: BaseColor.charcoal,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    String? prefixText,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixText: prefixText,
      prefixStyle: BaseTypography.bodyMedium.copyWith(
        color: BaseColor.charcoal,
        fontWeight: FontWeight.w600,
      ),
      hintStyle: BaseTypography.bodyMedium.copyWith(
        color: BaseColor.charcoal.withValues(alpha: 0.4),
      ),
      filled: true,
      fillColor: BaseColor.white,
      contentPadding: const EdgeInsets.symmetric(
        vertical: BaseSize.s16,
        horizontal: BaseSize.s16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFECEDE8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: BaseColor.karasko, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFB44B42)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFB44B42), width: 1.5),
      ),
    );
  }
}