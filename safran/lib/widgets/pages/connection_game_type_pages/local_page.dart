import 'package:flutter/material.dart';
import 'package:safran/widgets/components/buttons/basic_button.dart';
import 'package:safran/widgets/pages/setup_game_pages/host_game_page.dart';

import '../../components/header/custom_header.dart';
import '../setup_game_pages/join_game_page.dart';

class LocalPage extends StatelessWidget {

  const LocalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(),
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