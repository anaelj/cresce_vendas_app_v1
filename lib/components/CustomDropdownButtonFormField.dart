import 'package:flutter/material.dart';

class CustomDropdownButtonFormField<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final String? labelText;
  final String? hintText;
  final String? Function(T?)? validator;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? border;
  final Color? fillColor;
  final bool filled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomDropdownButtonFormField({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.labelText,
    this.hintText,
    this.validator,
    this.enabledBorder,
    this.focusedBorder,
    this.border,
    this.fillColor,
    this.filled = false,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              labelText!,
              style: const TextStyle(
                fontSize: 14,
                color: const Color(0xff565656),
              ),
            ),
          ),
        DropdownButtonFormField<T>(
          value: value,
          items: items,
          onChanged: onChanged,
          validator: validator,
          icon: const SizedBox.shrink(),
          style: const TextStyle(
            color: const Color(0xff565656),
          ),
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border: border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
            enabledBorder: enabledBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
            focusedBorder: focusedBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                ),
            fillColor: fillColor,
            filled: filled,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }
}
