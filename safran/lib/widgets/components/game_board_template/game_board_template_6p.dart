import 'dart:math';
import 'package:flutter/material.dart';
import 'package:safran/widgets/components/hands/opponent_hand.dart';
import 'package:safran/widgets/components/hands/main_hand.dart';
import 'package:safran/widgets/components/discard_pile/discard_pile.dart';
import '../../../entities/card/game_card.dart';
import '../../../entities/game.dart';
import '../../pages/settings_page/settings_page.dart';
import '../cards/game_card_component.dart';

class GameBoardTemplate6P extends StatefulWidget {
  final Game game;
  const GameBoardTemplate6P({super.key, required this.game});

  @override
  State<GameBoardTemplate6P> createState() => _GameBoardTemplate6PState();
}

class _GameBoardTemplate6PState extends State<GameBoardTemplate6P> {
  static const double handWidth = 80;
  static const double handHeight = 200;

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
                top: 25,
                right: MediaQuery.of(context).size.width / (1.25),
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

              // --- Middle-Left Opponent ---
              Positioned(
                top: -12.5,
                right: MediaQuery.of(context).size.width / (2.5),
                left: 0,
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
                        quarterTurns: 3,
                      );
                    },
                  ),
                ),
              ),

              // --- Middle Opponent ---
              Positioned(
                top: -50,
                right: 0,
                left: 0,
                child: GestureDetector(
                  onTap: () {
                    print("Opponent 3 tap !");
                    widget.game.players[0].choosePlayer(3);
                  },
                  child: AnimatedBuilder(
                    animation: widget.game.players[3],
                    builder: (context, _) {
                      return _buildOpponentColumn(
                        widget.game.players[3].userName,
                        widget.game.players[3].deck,
                        quarterTurns: 2,
                      );
                    },
                  ),
                ),
              ),

              // --- Middle-Right Opponent ---
              Positioned(
                top: -12.5,
                right: 0,
                left: MediaQuery.of(context).size.width / (2.5),
                child: GestureDetector(
                  onTap: () {
                    print("Opponent 4 tap !");
                    widget.game.players[0].choosePlayer(4);
                  },
                  child: AnimatedBuilder(
                    animation: widget.game.players[4],
                    builder: (context, _) {
                      return _buildOpponentColumn(
                        widget.game.players[4].userName,
                        widget.game.players[4].deck,
                        quarterTurns: 2,
                      );
                    },
                  ),
                ),
              ),

              // --- Right Opponent ---
              Positioned(
                top: 25,
                right: 0,
                left: MediaQuery.of(context).size.width / (1.25),
                child: GestureDetector(
                  onTap: () {
                    print("Opponent 5 tap !");
                    widget.game.players[0].choosePlayer(5);
                  },
                  child: AnimatedBuilder(
                    animation: widget.game.players[5],
                    builder: (context, _) {
                      return _buildOpponentColumn(
                        widget.game.players[5].userName,
                        widget.game.players[5].deck,
                        quarterTurns: 2,
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
