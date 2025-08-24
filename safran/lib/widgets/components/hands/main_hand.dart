import 'package:flutter/material.dart';
import 'package:safran/entities/card/game_card.dart';
import 'package:safran/entities/game.dart';
import 'package:safran/entities/player.dart';
import 'package:safran/services/logger.dart';
import 'package:safran/widgets/components/cards/game_card_component.dart';

import '../cards/opponent_game_card_component.dart';

class MainHand extends StatefulWidget {
  final Player player;
  final Game game;

  const MainHand({super.key, required this.player, required this.game});

  @override
  State<MainHand> createState() => _MainHandState();
}

class _MainHandState extends State<MainHand> {
  static const double handWidth = 400;
  static const double handHeight = 180;
  static const double cardWidth = 80;
  static const double maxOffset = 40;

  int? pressedIndex;

  void _updatePressedIndex(Offset globalPos, double startOffset, double offset) {
    final box = context.findRenderObject() as RenderBox;
    final local = box.globalToLocal(globalPos);
    final dx = local.dx - startOffset;
    final idx = (dx / offset).round();
    if (idx >= 0 && idx < widget.player.deck.length) {
      setState(() => pressedIndex = idx);
    } else {
      setState(() => pressedIndex = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final int cardCount = widget.player.deck.length;

    double offset = cardCount > 1
        ? (handWidth - cardWidth) / (cardCount - 1)
        : 0;
    offset = offset.clamp(0, maxOffset);

    final totalWidth = cardWidth + offset * (cardCount - 1);
    final startOffset = (handWidth - totalWidth) / 2;

    return SizedBox(
      width: handWidth,
      height: handHeight,
      child: GestureDetector(
        onPanDown: (details) =>
            _updatePressedIndex(details.globalPosition, startOffset, offset),
        onPanUpdate: (details) =>
            _updatePressedIndex(details.globalPosition, startOffset, offset),
        onPanEnd: (_) => setState(() => pressedIndex = null),
        onPanCancel: () => setState(() => pressedIndex = null),

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
                  _showCardDialog(context, index);
                },
                child: AnimatedScale(
                  scale: (pressedIndex == index) ? 1.6 : 1.0,
                  duration: const Duration(milliseconds: 150),
                  child: SizedBox(
                    width: cardWidth,
                    height: 120,
                    child: GameCardComponent(card: widget.player.deck[index]),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  void _showCardDialog(BuildContext context, int index) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) => Center(
        child: GestureDetector(
          onTap: () {
            Logger.info("tap");
            widget.player.chooseCard(index);
            setState(() {});
            Navigator.of(context).pop();
          },
          child: SizedBox(
            width: 200,
            height: 300,
            child: GameCardComponent(card: widget.player.deck[index]),
          ),
        ),
      ),
      transitionBuilder: (_, animation, __, child) =>
          ScaleTransition(
            scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
            child: child,
          ),
    );
  }
}
