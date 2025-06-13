import 'package:flutter/material.dart';
import 'package:safran/models/card/game_card.dart';
import 'package:safran/widgets/components/cards/game_card_component.dart';

import '../cards/opponent_game_card_component.dart';

class OpponentHand extends StatefulWidget {
  final List<GameCard> cards;

  const OpponentHand({super.key, required this.cards});

  @override
  State<OpponentHand> createState() => _OpponentHandState();
}

class _OpponentHandState extends State<OpponentHand> {
  static const double handWidth = 400;
  static const double handHeight = 180;
  static const double cardWidth = 80;
  static const double maxOffset = 40;

  int? pressedIndex;

  @override
  Widget build(BuildContext context) {
    final int cardCount = widget.cards.length;

    double offset = cardCount > 1
        ? (handWidth - cardWidth) / (cardCount - 1)
        : 0;
    offset = offset.clamp(0, maxOffset);

    final totalWidth = cardWidth + offset * (cardCount - 1);
    final startOffset = (handWidth - totalWidth) / 2;

    return SizedBox(
      width: handWidth,
      height: handHeight,
      child: Stack(
        children: List.generate(cardCount, (index) {
          final leftPos = startOffset + (index * offset);

          return Positioned(
            left: leftPos,
            child: SizedBox(
              width: cardWidth,
              height: 120,
              child: OpponentGameCardComponent(card: widget.cards[index]),
            ),
          );
        }),
      ),
    );
  }
}
