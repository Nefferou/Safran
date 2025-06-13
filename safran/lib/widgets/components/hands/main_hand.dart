import 'package:flutter/material.dart';
import 'package:safran/models/card/card_game.dart';
import 'package:safran/widgets/components/cards/game_card_component.dart';

class MainHand extends StatefulWidget {
  final List<GameCard> cards;

  const MainHand({Key? key, required this.cards}) : super(key: key);

  @override
  State<MainHand> createState() => _MainHandState();
}

class _MainHandState extends State<MainHand> {
  static const double handWidth = 400;
  static const double handHeight = 180;
  static const double cardWidth = 80;
  static const double maxOffset = 40;

  // Index de la carte actuellement pressée pour zoom
  int? pressedIndex;

  @override
  Widget build(BuildContext context) {
    final int cardCount = widget.cards.length;

    double offset = 0;
    if (cardCount > 1) {
      offset = (handWidth - cardWidth) / (cardCount - 1);
    }
    if (offset > maxOffset) offset = maxOffset;

    final totalCardsWidth = cardWidth + offset * (cardCount - 1);
    final startOffset = (handWidth - totalCardsWidth) / 2;

    return SizedBox(
      width: handWidth,
      height: handHeight,
      child: Stack(
        children: List.generate(cardCount, (index) {
          final leftPos = startOffset + (index * offset);

          return Positioned(
            left: leftPos,
            child: GestureDetector(
              onTapDown: (_) => setState(() => pressedIndex = index),
              onTapUp: (_) => setState(() => pressedIndex = null),
              onTapCancel: () => setState(() => pressedIndex = null),
              onTap: () {
                setState(() => pressedIndex = null);
                // Appui simple => on affiche la carte en grand via showDialog
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      child: Center(
                        child: Card(
                          elevation: 8,
                          child: SizedBox(
                            width: 200,
                            height: 300,
                            child: GameCardComponent(
                              card: widget.cards[index],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: AnimatedScale(
                scale: (pressedIndex == index) ? 1.6 : 1.0,
                duration: const Duration(milliseconds: 150),
                child: SizedBox(
                  width: cardWidth,
                  height: 120,
                  child: GameCardComponent(card: widget.cards[index]),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
