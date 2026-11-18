
import 'package:flutter/material.dart';

import '../../../core/constants/themes/color_constants.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.autofillHints,
    this.validator,
    this.isPassword = false,
    this.textInputAction,
    this.onFieldSubmitted,
    this.textCapitalization = TextCapitalization.none,
  });

  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Iterable<String>? autofillHints;
  final String? Function(String?)? validator;
  final bool isPassword;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final TextCapitalization textCapitalization;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  static const Color muted = Color(0xFF777C75);
  static const Color borderColor = Color(0xFFE3E6DF);
  static const Color errorColor = Color(0xFFB3261E);

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            color: BaseColor.karasko,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          autofillHints: widget.autofillHints,
          validator: widget.validator,
          obscureText: widget.isPassword && _obscureText,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          textCapitalization: widget.textCapitalization,
          cursorColor: BaseColor.karasko,
          textAlignVertical: TextAlignVertical.center,
          style: const TextStyle(
            color: BaseColor.charcoal,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: const TextStyle(
              color: Color(0xFF9DA29B),
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Icon(
              widget.icon,
              color: muted,
              size: 19,
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 46,
              minHeight: 48,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    tooltip: _obscureText
                        ? 'Tampilkan kata sandi'
                        : 'Sembunyikan kata sandi',
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    splashRadius: 20,
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: muted,
                      size: 19,
                    ),
                  )
                : null,
            filled: true,
            fillColor: const Color(0xFFFCFCFA),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 15,
            ),
            errorStyle: const TextStyle(
              color: errorColor,
              fontSize: 11,
              height: 1.3,
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: borderColor,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: borderColor,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: BaseColor.karasko,
                width: 1.4,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: errorColor,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: errorColor,
                width: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
