import 'package:flutter/material.dart';
import 'gradient_border/gradient_border_card.dart';

class GameModeTextButton extends StatelessWidget {
  final String text;
  final Widget redirectedPage;

  final double width;
  final double height;

  const GameModeTextButton({
    super.key,
    required this.text,
    required this.redirectedPage,
    this.width = 247,
    this.height = 128,
  });

  @override
  Widget build(BuildContext context) {
    const gradient = LinearGradient(
      colors: [Color(0xFFAE004B), Color(0xFFFFE5AC)],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    );

    return GradientBorderCard(
      width: width,
      height: height,
      radius: 12,
      strokeWidth: 5,
      gradient: gradient,
      backgroundColor: Colors.white.withOpacity(0.10),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(pageBuilder: (c, a1, a2) => redirectedPage),
        );
      },
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFEFCFB),
            fontFamily: 'Almendra',
          ),
        ),
      ),
    );
  }
}
