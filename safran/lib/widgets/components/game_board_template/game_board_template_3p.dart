import 'dart:math';
import 'package:flutter/material.dart';
import 'package:safran/services/logger.dart';
import 'package:safran/widgets/components/hands/opponent_hand.dart';
import 'package:safran/widgets/components/hands/main_hand.dart';
import 'package:safran/widgets/components/discard_pile/discard_pile.dart';
import '../../../entities/card/game_card.dart';
import '../../../entities/game.dart';
import '../../pages/setings_page/settings_page.dart';
import '../cards/game_card_component.dart';

class GameBoardTemplate3P extends StatefulWidget {
  final Game game;
  const GameBoardTemplate3P({super.key, required this.game});

  @override
  State<GameBoardTemplate3P> createState() => _GameBoardTemplate3PState();
}

class _GameBoardTemplate3PState extends State<GameBoardTemplate3P> {
  static const double handWidth = 400;
  static const double handHeight = 180;

  @override
  void initState() {
    super.initState();

    widget.game.startGame(0);
  }

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
                child: GestureDetector(
                  onTap: () {
                    print("Main tap !");
                    widget.game.players[0].choosePlayer(0);
                  },
                  child: AnimatedBuilder(
                    animation: widget.game.players[0],
                    builder: (context, _) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Your hand (${widget.game.players[0].deck.length} cards)",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          MainHand(
                            player: widget.game.players[0],
                            game: widget.game,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),

              // --- Discard Pile ---
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                top: 0,
                child: AnimatedBuilder(
                  animation: widget.game.battleField,
                  builder: (context, _) {
                    final upCard = widget.game.battleField.getUpCard();

                    return DiscardPile(
                      cards: [GameCardComponent(card: upCard)],
                      quarterTurns: 0,
                    );
                  },
                ),
              ),

              // --- Left Opponent ---
              Positioned(
                top: 0,
                right: MediaQuery.of(context).size.width / 2,
                left: 0,
                child: GestureDetector(
                  onTap: () {
                    print("Opponent 1 tap !");
                    widget.game.players[0].choosePlayer(1);
                  },
                  child: AnimatedBuilder(
                    animation: widget.game.players[1],
                    builder: (context, _) {
                      return _buildOpponentColumn(
                        widget.game.players[1].userName,
                        widget.game.players[1].deck,
                        quarterTurns: 1,
                      );
                    },
                  ),
                ),
              ),

              // --- Right Opponent ---
              Positioned(
                top: 0,
                right: 0,
                left: MediaQuery.of(context).size.width / 2,
                child: GestureDetector(
                  onTap: () {
                    print("Opponent 2 tap !");
                    widget.game.players[0].choosePlayer(2);
                  },
                  child: AnimatedBuilder(
                    animation: widget.game.players[2],
                    builder: (context, _) {
                      return _buildOpponentColumn(
                        widget.game.players[2].userName,
                        widget.game.players[2].deck,
                        quarterTurns: 1,
                      );
                    },
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
