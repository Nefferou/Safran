import 'package:flutter/material.dart';

class _GradientBorderPainter extends CustomPainter {
  final LinearGradient gradient;
  final double strokeWidth;
  final double radius;

  _GradientBorderPainter({
    required this.gradient,
    required this.strokeWidth,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final inset = strokeWidth / 2;
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(inset, inset, size.width - strokeWidth, size.height - strokeWidth),
      Radius.circular(radius - inset),
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = gradient.createShader(rect)
      ..isAntiAlias = true;

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant _GradientBorderPainter old) =>
      old.gradient != gradient || old.strokeWidth != strokeWidth || old.radius != radius;
}

class GradientBorderCard extends StatelessWidget {
  final Widget child;
  final double radius;
  final double strokeWidth;
  final LinearGradient gradient;
  final Color backgroundColor;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;

  const GradientBorderCard({
    super.key,
    required this.child,
    required this.gradient,
    this.radius = 12,
    this.strokeWidth = 5,
    this.backgroundColor = Colors.transparent,
    this.onTap,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    final content = Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: _GradientBorderPainter(
              gradient: gradient,
              strokeWidth: strokeWidth,
              radius: radius,
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(radius - 0.5),
            ),
            child: child,
          ),
        ),
      ],
    );

    final interactive = Material(
      type: MaterialType.transparency,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        overlayColor: MaterialStateProperty.all(Colors.white24),
        highlightColor: Colors.transparent,
        child: content,
      ),
    );

    return SizedBox(
      width: width,
      height: height,
      child: onTap == null ? content : interactive,
    );
  }
}
