import 'package:cresce_vendas_app_v1/components/dashed_border_painter.dart';
import 'package:flutter/material.dart';

class DashedBorderContainer extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final double strokeWidth;
  final double borderRadius;
  final double dashWidth;
  final double dashSpace;
  final EdgeInsetsGeometry padding;

  const DashedBorderContainer({
    Key? key,
    required this.child,
    this.borderColor = Colors.grey,
    this.strokeWidth = 2.0,
    this.borderRadius = 8.0,
    this.dashWidth = 5.0,
    this.dashSpace = 5.0,
    this.padding = const EdgeInsets.all(16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
        color: borderColor,
        strokeWidth: strokeWidth,
        borderRadius: borderRadius,
        dashWidth: dashWidth,
        dashSpace: dashSpace,
      ),
      child: Container(
        width: double.infinity, // Ocupa toda a largura disponível
        padding: padding, // Padding interno
        child: child,
      ),
    );
  }
}
