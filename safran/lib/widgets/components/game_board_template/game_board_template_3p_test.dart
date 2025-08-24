import 'dart:math';
import 'package:flutter/material.dart';
import 'package:safran/services/logger.dart';
import 'package:safran/widgets/components/hands/opponent_hand.dart';
import 'package:safran/widgets/components/hands/main_hand.dart';
import 'package:safran/widgets/components/discard_pile/discard_pile.dart';
import 'package:safran/widgets/components/popup/custom_popup.dart';
import '../../../entities/card/game_card.dart';
import '../../../entities/game.dart';
import '../../pages/home_page.dart';
import '../../pages/settings_page/rules_page.dart';
import '../../pages/settings_page/settings_page.dart';
import '../cards/game_card_component.dart';

class GameBoardTemplate3PTest extends StatefulWidget {
  final Game game;
  const GameBoardTemplate3PTest({super.key, required this.game});

  @override
  State<GameBoardTemplate3PTest> createState() => _GameBoardTemplate3PState();
}

class _GameBoardTemplate3PState extends State<GameBoardTemplate3PTest> {
  static const double handWidth = 400;
  static const double handHeight = 80;

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
              // --- BACKGROUND IMAGE ---
              Positioned.fill(
                child: Image.asset(
                  "res/assets/game_board/background.png",
                  fit: BoxFit.cover,
                ),
              ),

              // --- BOARD IMAGE ---
              Positioned.fill(
                child: Center(
                  child: Image.asset(
                    "res/assets/game_board/board.png",
                    width: 1300,
                    height: 1300,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // --- MENU BUTTON ---
              Positioned(
                top: 20,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CustomPopup(
                          title: "Menu",
                          child: IntrinsicWidth(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => const RulesPage()),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.menu_book, color: Color(0xFFFFE5AC)),
                                        SizedBox(width: 10),
                                        Text(
                                          "Règles du jeu",
                                          style: TextStyle(color: Color(0xFFFFE5AC), fontSize: 24, fontFamily: 'Almendra'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  width: double.infinity,
                                  child: Divider(color: Color(0xFFFFE5AC), thickness: 2),
                                ),

                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => const SettingsPage()),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.settings, color: Color(0xFFFFE5AC)),
                                        SizedBox(width: 10),
                                        Text(
                                          "Paramètre",
                                          style: TextStyle(color: Color(0xFFFFE5AC), fontSize: 24, fontFamily: 'Almendra'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  width: double.infinity,
                                  child: Divider(color: Color(0xFFFFE5AC), thickness: 2),
                                ),

                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (_) => const HomePage()),
                                          (route) => false,
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.home, color: Color(0xFFFFE5AC)),
                                        SizedBox(width: 10),
                                        Text(
                                          "Quitter la partie",
                                          style: TextStyle(color: Color(0xFFFFE5AC), fontSize: 24, fontFamily: 'Almendra'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Image.asset(
                    "res/assets/game_board/Nav.png",
                    width: 50,
                    height: 50,
                  ),
                ),
              ),

              // --- Main Hand ---
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    print("Main tap !");
                    widget.game.players[widget.game.currentPlayerTurn].choosePlayer(0);
                  },
                  child: AnimatedBuilder(
                    animation: widget.game.players[0],
                    builder: (context, _) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${widget.game.players[0].userName} (${widget.game.players[0].deck.length})",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          MainHand(
                            player: widget.game.players[0],
                            game: widget.game,
                            handWidth: 400,
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
                right: MediaQuery.of(context).size.width / 2,
                left: 0,
                child: GestureDetector(
                  onTap: () {
                    print("Opponent 1 tap !");
                    widget.game.players[widget.game.currentPlayerTurn].choosePlayer(1);
                  },
                  child: AnimatedBuilder(
                    animation: widget.game.players[1],
                    builder: (context, _) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${widget.game.players[1].userName} (${widget.game.players[1].deck.length})",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          MainHand(
                            player: widget.game.players[1],
                            game: widget.game,
                            handWidth: 200,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),

              // --- Right Opponent ---
              Positioned(
                top: 25,
                right: 0,
                left: MediaQuery.of(context).size.width / 2,
                child: GestureDetector(
                  onTap: () {
                    print("Opponent 2 tap !");
                    widget.game.players[widget.game.currentPlayerTurn].choosePlayer(2);
                  },
                  child: AnimatedBuilder(
                    animation: widget.game.players[2],
                    builder: (context, _) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${widget.game.players[2].userName} (${widget.game.players[2].deck.length})",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          MainHand(
                            player: widget.game.players[2],
                            game: widget.game,
                            handWidth: 200,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),

              // --- Action Message ---
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: AnimatedBuilder(
                  animation: widget.game,
                  builder: (context, _) {
                    return Center(
                      child: Text(
                        widget.game.actionMessage.isNotEmpty
                            ? widget.game.actionMessage
                            : "En attente...",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
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
