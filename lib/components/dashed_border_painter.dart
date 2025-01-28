import 'package:flutter/material.dart';

class DashedBorderPainter extends CustomPainter {
  final Color color; // Cor da borda
  final double strokeWidth; // Espessura da borda
  final double borderRadius; // Raio dos cantos arredondados
  final double dashWidth; // Largura do traço
  final double dashSpace; // Espaço entre os traços

  DashedBorderPainter({
    this.color = Colors.grey, // Cor padrão
    this.strokeWidth = 2.0, // Espessura padrão
    this.borderRadius = 8.0, // Raio padrão
    this.dashWidth = 5.0, // Largura do traço padrão
    this.dashSpace = 5.0, // Espaço entre os traços padrão
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(borderRadius),
      ));

    // Simular borda pontilhada
    final pathMetrics = path.computeMetrics();
    for (final pathMetric in pathMetrics) {
      var distance = 0.0;
      while (distance < pathMetric.length) {
        canvas.drawPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
