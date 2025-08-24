import 'dart:math';

import 'package:flutter/material.dart';
import 'package:safran/widgets/components/buttons/basic_button.dart';
import 'package:safran/widgets/components/header/custom_header.dart';
import 'package:safran/widgets/pages/connection_game_type_pages/local_page.dart';
import 'package:safran/widgets/pages/connection_game_type_pages/online_page.dart';
import 'package:safran/widgets/pages/game_board_page/game_board_page.dart';
import 'package:safran/widgets/pages/settings_page/rules_page.dart';
import 'package:safran/widgets/pages/settings_page/settings_page.dart';

import '../../entities/game.dart';
import '../../entities/player.dart';
import '../components/buttons/game_mode_button.dart';

class HomePage extends StatelessWidget {

  const HomePage({super.key});

  static const double _headerHeight = 100;
  static const double _gapBelowHeader = 10;

  @override
  Widget build(BuildContext context) {

    final double topInset = MediaQuery.of(context).padding.top;

    List<Player> players = [
      Player("Player 1"),
      Player("Player 2"),
      Player("Player 3"),
    ];

    Game game = Game(players);

    game.setUpGame(Random().nextInt(players.length));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomHeader(
        onBookTap: (){
          Navigator.push(
            context,
            PageRouteBuilder(pageBuilder: (c, a1, a2) => RulesPage()),
          );
        },
        onSettingsTap: (){
          Navigator.push(
            context,
            PageRouteBuilder(pageBuilder: (c, a1, a2) => SettingsPage()),
          );
        },
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("res/assets/home/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: topInset + _headerHeight + _gapBelowHeader, bottom: 20),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GameModeButton(text: "Jouer en\nligne", imagePath: "res/assets/home/internet.png", redirectedPage: OnlinePage()),
                  const SizedBox(width: 46,),
                  GameModeButton(text: "Jouer en\nlocal", imagePath: "res/assets/home/local.png", redirectedPage: OnlinePage()),
                  const SizedBox(width: 46,),
                  GameModeButton(text: "Partie de test Admin", imagePath: "res/assets/home/test.png", redirectedPage: GameBoardPage(game: game, isTestGame: true))
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }

}