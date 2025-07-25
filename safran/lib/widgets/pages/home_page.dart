import 'dart:math';

import 'package:flutter/material.dart';
import 'package:safran/widgets/components/buttons/basic_button.dart';
import 'package:safran/widgets/components/header/custom_header.dart';
import 'package:safran/widgets/pages/connection_game_type_pages/local_page.dart';
import 'package:safran/widgets/pages/connection_game_type_pages/online_page.dart';
import 'package:safran/widgets/pages/game_board_page/game_board_page.dart';

import '../../entities/game.dart';
import '../../entities/player.dart';

class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    List<Player> players = [
      Player("Player 1"),
      Player("Player 2"),
      Player("Player 3"),
    ];

    Game game = Game(players);

    game.setUpGame(Random().nextInt(players.length));

    return Scaffold(
      appBar: CustomHeader(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BasicButton(text: "Online Games", redirectedPage: OnlinePage()),
            BasicButton(text: "Local Games", redirectedPage: LocalPage()),
            BasicButton(text: "Test Board Game", redirectedPage: GameBoardPage(game: game,))
          ],
        ),
      ),
    );
  }

}