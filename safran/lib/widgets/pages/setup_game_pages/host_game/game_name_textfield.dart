import 'package:flutter/material.dart';

class GameNameTextField extends StatelessWidget {
  final TextEditingController controller;
  const GameNameTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 230),
      child: Container(
        width: 230,
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFFFE5AC),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFFAE004B),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Almendra',
                ),
                maxLines: 1,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Nom de la partie',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(174, 0, 75, 0.6),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Almendra',
                  ),
                ),
              ),
            ),
            Image.asset("res/assets/host_game/edit.png"),
          ],
        ),
      ),
    );
  }
}
