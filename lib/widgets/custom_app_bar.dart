import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    required String titleText,
    Key? key,
  }) : super(
          key: key,
          iconTheme: const IconThemeData(
            color: Color(0xFF007FBA), // Cor fixa para o ícone de voltar
          ),
          title: Text(
            titleText,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xFF403E43),
              fontSize: 16,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: const Color(0xFF007FBA),
              height: 1.0,
            ),
          ),
        );
}
