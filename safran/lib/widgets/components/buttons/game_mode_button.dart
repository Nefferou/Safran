import 'package:flutter/material.dart';

import 'gradient_border/gradient_border_card.dart';

class GameModeButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final Widget redirectedPage;

  const GameModeButton({
    super.key,
    required this.text,
    required this.imagePath,
    required this.redirectedPage,
  });

  @override
  Widget build(BuildContext context) {
    const gradient = LinearGradient(
      colors: [Color(0xFFAE004B), Color(0xFFFFE5AC)],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    );

    return GradientBorderCard(
      width: 128,
      height: 247,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFEFCFB),
              fontFamily: 'Almendra',
            ),
          ),
          const SizedBox(height: 10),
          Image.asset(
            imagePath,
            width: 80,
            height: 80,
            color: const Color(0xFFFEFCFB),
          ),
        ],
      ),
    );
  }
}
