import 'package:flutter/material.dart';

import '../../components/buttons/basic_button.dart';
import '../../components/header/custom_header.dart';
import '../settings_page/rules_page.dart';
import '../settings_page/settings_page.dart';
import '../setup_game_pages/host_game/host_game_page.dart';
import '../setup_game_pages/join_game/join_game_page.dart';

class OnlinePage extends StatelessWidget {

  const OnlinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BasicButton(text: "Host game", redirectedPage: HostGamePage()),
            BasicButton(text: "Join game", redirectedPage: JoinGamePage()),
          ],
        ),
      ),
    );
  }

}