import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final int? maxLines;
  final int? minLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? border;
  final Color? fillColor;
  final bool filled;
  final bool readOnly;
  final void Function()? onTap;

  const CustomTextFormField({
    Key? key,
    this.controller,
    required this.labelText,
    this.hintText,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.minLines,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onSaved,
    this.enabledBorder,
    this.focusedBorder,
    this.border,
    this.fillColor,
    this.filled = false,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label acima do input
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0), // Espaçamento de 4px
          child: Text(
            labelText,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xff565656),
            ),
          ),
        ),
        // Input
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: maxLines,
          minLines: minLines,
          readOnly: readOnly,
          onTap: onTap,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border: border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
            enabledBorder: enabledBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
            focusedBorder: focusedBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
            fillColor: fillColor,
            filled: filled,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
          validator: validator,
          onChanged: onChanged,
          onSaved: onSaved,
        ),
      ],
    );
  }
}
