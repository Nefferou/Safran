import 'package:flutter/material.dart';
import '../../components/buttons/game_mode_text_button.dart';
import 'package:safran/widgets/pages/setup_game_pages/host_game/host_game_page.dart';

import '../../components/header/custom_header.dart';
import '../settings_page/rules_page.dart';
import '../settings_page/settings_page.dart';
import '../setup_game_pages/join_game/join_game_page.dart';

class LocalPage extends StatelessWidget {

  const LocalPage({super.key});

  static const double _headerHeight = 100;
  static const double _gapBelowHeader = 10;

  @override
  Widget build(BuildContext context) {
    final double topInset = MediaQuery.of(context).padding.top;

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
          // même background que la Home
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("res/assets/home/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: topInset + _headerHeight + _gapBelowHeader,
              bottom: 20,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GameModeTextButton(
                    text: "Host\ngame",
                    redirectedPage: HostGamePage(),
                  ),
                  const SizedBox(height: 46),
                  GameModeTextButton(
                    text: "Join\ngame",
                    redirectedPage: JoinGamePage(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}