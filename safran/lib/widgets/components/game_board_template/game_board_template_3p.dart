import 'package:flutter/material.dart';

import '../../../entities/game.dart';
import '../hands/main_hand.dart';
import '../header/custom_header.dart';

class GameBoardTemplate3P extends StatefulWidget {
  final Game game;

  const GameBoardTemplate3P({super.key, required this.game});

  @override
  State<StatefulWidget> createState() => _GameBoardTemplate3PState();

}

class _GameBoardTemplate3PState extends State<GameBoardTemplate3P> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(),
      body: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: -100,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MainHand(cards: widget.game.players[0].deck),
                  ],
                ),
              ),
            ),
            /*Positioned(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MainHand(cards: widget.game.players[1].deck),
                  ],
                ),
              ),
            )*/
          ]
      ),
    );
  }
}