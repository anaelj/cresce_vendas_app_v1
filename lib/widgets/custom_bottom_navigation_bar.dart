import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final String caption;
  final VoidCallback onPressed;

  const CustomBottomNavigationBar({
    Key? key,
    required this.caption,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 108,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, -4),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF007FBA),
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          caption,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
