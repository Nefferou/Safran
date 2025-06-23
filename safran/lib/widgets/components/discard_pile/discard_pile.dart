import 'package:flutter/material.dart';
import 'package:safran/widgets/components/cards/game_card_component.dart';

class DiscardPile extends StatefulWidget {
  final List<GameCardComponent> cards;
  final int quarterTurns;

  const DiscardPile({super.key, required this.cards, this.quarterTurns = 1});

  @override
  State<DiscardPile> createState() => _DiscardPileState();
}

class _DiscardPileState extends State<DiscardPile> {
  static const double cardWidth = 80;
  int? pressedIndex;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Center(
        child: RotatedBox(
          quarterTurns: widget.quarterTurns,
          child: Container(
            width: 80,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black,
                width: 3,
              ),
            ),
            child: Stack(
                children: [
                  RotatedBox(
                    quarterTurns: 3,
                    child: Center(
                      child: Text("Discard Pile",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  ...widget.cards.map(
                        (card) => Positioned(
                        child: GestureDetector(
                          onTapDown: (_) => setState(() => pressedIndex = 0),
                          onTapUp: (_) => setState(() => pressedIndex = null),
                          onTapCancel: () => setState(() => pressedIndex = null),
                          onTap: () {
                            setState(() => pressedIndex = null);
                            _showCardDialog(context, 0);
                          },
                          child: SizedBox(
                            width: cardWidth,
                            height: 120,
                            child: widget.cards[0],
                          ),
                        ),
                    ),
                  ),
                ]
            ),
          ),
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
          onTap: () => Navigator.of(context).pop(),
          child: SizedBox(
            width: 200,
            height: 300,
            child: widget.cards[0],
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