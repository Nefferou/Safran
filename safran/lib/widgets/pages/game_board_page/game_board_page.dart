import 'package:flutter/material.dart';
import 'package:safran/widgets/components/game_board_template/game_board_template_3p.dart';
import 'package:safran/widgets/components/hands/main_hand.dart';
import 'package:safran/widgets/components/header/custom_header.dart';

import '../../../models/game.dart';

class GameBoardPage extends StatefulWidget {

  final Game game;

  const GameBoardPage({super.key, required this.game});

  @override
  State<GameBoardPage> createState() => _GameBoardPageState();
}

class _GameBoardPageState extends State<GameBoardPage> {
  @override
  Widget build(BuildContext context) {
    if(widget.game.players.length == 3) {
      return GameBoardTemplate3P(game: widget.game);
    } else {
      return const Center(child: Text("Not implemented yet"));
    }
  }
}