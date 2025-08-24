import 'package:flutter/material.dart';

class CustomPopup extends StatelessWidget {
  final String title;
  final Widget child;

  const CustomPopup({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent, // fond transparent
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // --- BODY POPUP ---
          ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 300,
              minHeight: 200,
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFAE004B),
                    Color(0xFF54016E),
                  ],
                ),
              ),
              child: child,
            ),
          ),

          // --- CLOSE BUTTON ---
          Positioned(
            top: -15,
            right: -15,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFAE004B),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.close,
                  color: const Color(0xFFFFE5AC),
                ),
              ),
            ),
          ),

          // --- TITLE ---
          Positioned(
            top: -25,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFAE004B),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFFFFE5AC),
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Almendra'
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}