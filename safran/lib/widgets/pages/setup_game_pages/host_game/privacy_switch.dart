import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

enum Privacy { private, public }

class PrivacySwitch extends StatefulWidget {
  const PrivacySwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.height = 44,
    this.privateLabel = 'Privé',
    this.publicLabel = 'Public',
    this.privateColor = const Color(0xFFAE004B),
    this.publicColor = const Color(0xFFFFE5AC),
    this.textStyle,
    this.radius = 22,
    this.diagonalOffset = 28,
    this.animationDuration = const Duration(milliseconds: 220),
    this.leftFracPrivate = 0.65,
    this.leftFracPublic = 0.45,
  });

  final Privacy value;
  final ValueChanged<Privacy> onChanged;

  final double height;
  final double radius;
  final double diagonalOffset;
  final Duration animationDuration;

  final String privateLabel;
  final String publicLabel;
  final Color privateColor;
  final Color publicColor;
  final TextStyle? textStyle;

  final double leftFracPrivate;
  final double leftFracPublic;

  @override
  State<PrivacySwitch> createState() => _PrivacySwitchState();
}

class _PrivacySwitchState extends State<PrivacySwitch>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late Animation<double> _t;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.animationDuration);
    _t = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);

    _ctrl.value = widget.value == Privacy.private ? 0.0 : 1.0;
  }

  @override
  void didUpdateWidget(covariant PrivacySwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    final target = widget.value == Privacy.private ? 0.0 : 1.0;
    if ((_ctrl.value - target).abs() > 0.001) {
      _ctrl.animateTo(target);
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _tapLeft() => widget.onChanged(Privacy.private);
  void _tapRight() => widget.onChanged(Privacy.public);

  @override
  Widget build(BuildContext context) {
    final ts = (widget.textStyle ??
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          fontFamily: 'Almendra',
        ))
        .copyWith(height: 1.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.hasBoundedWidth
            ? constraints.maxWidth
            : widget.height * 3;

        return ConstrainedBox(
          constraints: BoxConstraints.tightFor(
            width: width,
            height: widget.height,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.radius),
            child: Stack(
              fit: StackFit.expand,
              children: [
                AnimatedBuilder(
                  animation: _t,
                  builder: (context, _) {
                    return CustomPaint(
                      painter: _DiagonalSplitPainter(
                        t: _t.value,
                        radius: widget.radius,
                        diagonalOffset: widget.diagonalOffset,
                        leftColor: widget.privateColor,
                        rightColor: widget.publicColor,
                        leftFracPrivate: widget.leftFracPrivate,
                        leftFracPublic: widget.leftFracPublic,
                      ),
                    );
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: _tapLeft,
                        child: Center(
                          child: Text(
                            widget.privateLabel,
                            style: ts.copyWith(
                              color: Color(0xFFFFE5AC),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: _tapRight,
                        child: Center(
                          child: Text(
                            widget.publicLabel,
                            style: ts.copyWith(
                              color: const Color(0xFFAE004B),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Semantics(
                  container: true,
                  label: 'Sélecteur de confidentialité',
                  value: widget.value == Privacy.private ? 'Privé' : 'Public',
                  toggled: widget.value == Privacy.public,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DiagonalSplitPainter extends CustomPainter {
  _DiagonalSplitPainter({
    required this.t,
    required this.radius,
    required this.diagonalOffset,
    required this.leftColor,
    required this.rightColor,
    required this.leftFracPrivate,
    required this.leftFracPublic,
  });

  final double t;
  final double radius;
  final double diagonalOffset;
  final Color leftColor;
  final Color rightColor;
  final double leftFracPrivate;
  final double leftFracPublic;

  @override
  void paint(Canvas canvas, Size size) {
    final r = Radius.circular(radius);
    final rect = Offset.zero & size;

    final leftFrac = lerpDouble(leftFracPrivate, leftFracPublic, t)!;
    final cutCenter = size.width * leftFrac;
    final xTop = cutCenter;
    final xBottom = cutCenter - diagonalOffset;

    final paintLeft = Paint()..color = leftColor;
    final paintRight = Paint()..color = rightColor;

    final pathLeft = Path()
      ..moveTo(0, r.x)
      ..arcToPoint(Offset(r.x, 0), radius: r)
      ..lineTo(size.width - size.width + xTop, 0)
      ..lineTo(math.max(0, xBottom), size.height)
      ..lineTo(r.x, size.height)
      ..arcToPoint(Offset(0, size.height - r.x), radius: r)
      ..close();

    final pathRight = Path()
      ..moveTo(xTop, 0)
      ..lineTo(size.width - r.x, 0)
      ..arcToPoint(Offset(size.width, r.x), radius: r)
      ..lineTo(size.width, size.height - r.x)
      ..arcToPoint(Offset(size.width - r.x, size.height), radius: r)
      ..lineTo(math.max(xBottom, 0), size.height)
      ..close();

    canvas.drawPath(pathLeft, paintLeft);
    canvas.drawPath(pathRight, paintRight);
  }

  @override
  bool shouldRepaint(covariant _DiagonalSplitPainter oldDelegate) {
    return t != oldDelegate.t ||
        radius != oldDelegate.radius ||
        diagonalOffset != oldDelegate.diagonalOffset ||
        leftColor != oldDelegate.leftColor ||
        rightColor != oldDelegate.rightColor;
  }
}
