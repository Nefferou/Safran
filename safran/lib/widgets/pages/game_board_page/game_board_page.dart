import 'package:flutter/material.dart';
import 'package:safran/widgets/components/game_board_template/game_board_template_3p.dart';
import 'package:safran/widgets/pages/setings_page/settings_page.dart';

import '../../../entities/game.dart';
import '../../components/game_board_template/game_board_template_4p.dart';
import '../../components/game_board_template/game_board_template_5p.dart';
import '../../components/game_board_template/game_board_template_6p.dart';

class GameBoardPage extends StatefulWidget {

  final Game game;

  const GameBoardPage({super.key, required this.game});

  @override
  State<GameBoardPage> createState() => _GameBoardPageState();
}

class _GameBoardPageState extends State<GameBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.game.players.length == 3
          ? GameBoardTemplate3P(game: widget.game)
          : widget.game.players.length == 4
            ? GameBoardTemplate4P(game: widget.game)
            : widget.game.players.length == 5
              ? GameBoardTemplate5P(game: widget.game)
              : widget.game.players.length == 6
                ? GameBoardTemplate6P(game: widget.game)
                : Center(
                    child: Text("Unsupported number of players"),
                  ),
    );
  }
}