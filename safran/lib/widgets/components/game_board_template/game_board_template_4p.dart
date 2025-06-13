import 'dart:math';
import 'package:flutter/material.dart';
import 'package:safran/widgets/components/hands/opponent_hand.dart';
import 'package:safran/widgets/components/hands/main_hand.dart';
import 'package:safran/widgets/components/discard_pile/discard_pile.dart';
import 'package:safran/widgets/components/header/custom_header.dart';
import '../../../models/card/game_card.dart';
import '../../../models/game.dart';
import '../cards/game_card_component.dart';

class GameBoardTemplate4P extends StatefulWidget {
  final Game game;
  const GameBoardTemplate4P({super.key, required this.game});

  @override
  State<GameBoardTemplate4P> createState() => _GameBoardTemplate4PState();
}

class _GameBoardTemplate4PState extends State<GameBoardTemplate4P> {
  static const double handWidth = 400;
  static const double handHeight = 180;

  bool isHeader = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (isHeader) ? CustomHeader() : null,
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          // 1. height available
          final availableH = constraints.maxHeight;
          // 2. required height after the rotation
          const double rotatedHandH = handWidth;
          // 3. scale factor
          final double scale = min(1.0, availableH / rotatedHandH);

          return Stack(
            clipBehavior: Clip.none,
            children: [
              // --- Main Hand ---
              Positioned(
                bottom: -100,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Your hand (${widget.game.players[0].deck.length} cards)",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    MainHand(cards: widget.game.players[0].deck),
                  ],
                ),
              ),

              // --- Discard Pile ---
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                top: 0,
                child: DiscardPile(
                  cards: [
                    GameCardComponent(
                        card: widget.game.battleField.getUpCard())
                  ],
                  quarterTurns: 1,
                ),
              ),

              // --- Left Opponent ---
              Positioned(
                top: 0,
                left: -50,
                child: Transform.scale(
                  scale: scale,
                  alignment: Alignment.topLeft, // ancre la réduction en haut à gauche
                  child: _buildOpponentColumn(
                    widget.game.players[1].userName,
                    widget.game.players[1].deck,
                    quarterTurns: 1,
                  ),
                ),
              ),

              // --- Right Opponent ---
              Positioned(
                top: 0,
                right: -50,
                child: Transform.scale(
                  scale: scale,
                  alignment: Alignment.topRight,
                  child: _buildOpponentColumn(
                    widget.game.players[2].userName,
                    widget.game.players[2].deck,
                    quarterTurns: 3,
                  ),
                ),
              ),

              // --- Top Opponent ---
              Positioned(
                top: -50,
                right: (isHeader) ? 170 : 100,
                left: 0,
                child: Transform.scale(
                  scale: scale,
                  alignment: Alignment.topRight,
                  child: _buildOpponentColumn(
                    widget.game.players[3].userName,
                    widget.game.players[3].deck,
                    quarterTurns: 2,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildOpponentColumn(
      String name, List<GameCard> cards, {required int quarterTurns}) {
    return RotatedBox(
      quarterTurns: quarterTurns,
      child: SizedBox(
        width: handWidth,
        height: handHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$name (${cards.length} cards)",
                style:
                const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            OpponentHand(cards: cards),
          ],
        ),
      ),
    );
  }
}
