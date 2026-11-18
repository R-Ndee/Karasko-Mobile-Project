import 'package:flutter/material.dart';

import '../../../../core/constants/themes/color_constants.dart';
import '../../../../core/constants/themes/size_constants.dart';
import '../../../../core/constants/themes/typography_constants.dart';
import '../models/admin_product.dart';

class DeleteProductDialog extends StatelessWidget {
  final AdminProduct product;

  const DeleteProductDialog({
    super.key,
    required this.product,
  });

  static Future<bool?> show(BuildContext context, AdminProduct product) {
    return showDialog<bool>(
      context: context,
      builder: (_) => DeleteProductDialog(product: product),
    );
  }

  @override
  Widget build(BuildContext context) {
    const dangerColor = Color(0xFFB44B42);

    return Dialog(
      backgroundColor: BaseColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(BaseSize.s24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: dangerColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.delete_outline_rounded,
                color: dangerColor,
                size: 30,
              ),
            ),
            Gap.h16,
            Text(
              'Hapus Produk?',
              style: BaseTypography.headlineSmall.copyWith(
                color: BaseColor.charcoal,
                fontWeight: FontWeight.w800,
              ),
            ),
            Gap.h8,
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: BaseTypography.bodyMedium.copyWith(
                  color: BaseColor.charcoal.withValues(alpha: 0.7),
                ),
                children: [
                  const TextSpan(text: 'Apakah kamu yakin ingin menghapus '),
                  TextSpan(
                    text: product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: BaseColor.charcoal,
                    ),
                  ),
                  const TextSpan(
                    text: '? Produk yang dihapus tidak dapat dikembalikan.',
                  ),
                ],
              ),
            ),
            Gap.h24,
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: BaseColor.charcoal,
                      padding: const EdgeInsets.symmetric(
                        vertical: BaseSize.s14,
                      ),
                      side: const BorderSide(
                        color: Color(0xFFE0E2DC),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Batal',
                      style: BaseTypography.labelLarge.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Gap.w12,
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: dangerColor,
                      foregroundColor: BaseColor.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        vertical: BaseSize.s14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Hapus',
                      style: BaseTypography.labelLarge.copyWith(
                        color: BaseColor.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}