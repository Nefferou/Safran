import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../models/card/game_card.dart';

class OpponentGameCardComponent extends StatefulWidget {

  final GameCard card;

  const OpponentGameCardComponent({super.key, required this.card});

  @override
  State<OpponentGameCardComponent> createState() => _OpponentGameCardComponentState();

}

class _OpponentGameCardComponentState extends State<OpponentGameCardComponent> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Image.asset(
        "res/assets/cards/back_card_empty.png",
        fit: BoxFit.cover,
      ),
    );
  }
}