import 'package:flutter/material.dart';
import 'package:safran/models/card/game_card.dart';

class OpponentHand extends StatefulWidget {
  final List<GameCard> cards;

  const OpponentHand({super.key, required this.cards});

  @override
  State<OpponentHand> createState() => _OpponentHandState();
}

class _OpponentHandState extends State<OpponentHand> {
  static const double cardWidth = 80;
  static const double cardHeight = 120;

  int? pressedIndex;

  @override
  Widget build(BuildContext context) {
    final int cardCount = widget.cards.length;

    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: Stack(
        children: [
          Positioned(
            child: Image.asset(
              "res/assets/cards/back_card_empty.png",
              width: cardWidth,
              height: cardHeight,
            ),
          ),
          Positioned(
            child: Center(
              child: Text(
                "$cardCount",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}