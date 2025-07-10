import 'dart:math';
import 'package:flutter/material.dart';
import 'package:safran/widgets/components/hands/opponent_hand.dart';
import 'package:safran/widgets/components/hands/main_hand.dart';
import 'package:safran/widgets/components/discard_pile/discard_pile.dart';
import '../../../entities/card/game_card.dart';
import '../../../entities/game.dart';
import '../../pages/setings_page/settings_page.dart';
import '../cards/game_card_component.dart';

class GameBoardTemplate5P extends StatefulWidget {
  final Game game;
  const GameBoardTemplate5P({super.key, required this.game});

  @override
  State<GameBoardTemplate5P> createState() => _GameBoardTemplate5PState();
}

class _GameBoardTemplate5PState extends State<GameBoardTemplate5P> {
  static const double handWidth = 80;
  static const double handHeight = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) => SettingsPage(),
                      ),
                    );
                  },
                ),
              ),

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
                top: 25,
                right: MediaQuery.of(context).size.width / (4/3),
                left: 0,
                child: Transform.scale(
                  scale: scale,
                  alignment: Alignment.topLeft,
                  child: _buildOpponentColumn(
                    widget.game.players[1].userName,
                    widget.game.players[1].deck,
                    quarterTurns: 1,
                  ),
                ),
              ),

              // --- Middle-Left Opponent ---
              Positioned(
                top: -50,
                right: MediaQuery.of(context).size.width / 3,
                left: 0,
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

              // --- Middle-Right Opponent ---
              Positioned(
                top: -50,
                right: 0,
                left: MediaQuery.of(context).size.width / 3,
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

              // --- Right Opponent ---
              Positioned(
                top: 25,
                right: 0,
                left: MediaQuery.of(context).size.width / (4/3),
                child: Transform.scale(
                  scale: scale,
                  alignment: Alignment.topRight,
                  child: _buildOpponentColumn(
                    widget.game.players[4].userName,
                    widget.game.players[4].deck,
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
    return SizedBox(
      width: handWidth,
      height: handHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name,
              style:
              const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          OpponentHand(cards: cards),
        ],
      ),
    );
  }
}
