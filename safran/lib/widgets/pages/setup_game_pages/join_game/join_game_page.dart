import 'package:flutter/material.dart';
import 'package:safran/widgets/pages/setup_game_pages/join_game/join_game_card.dart';

import '../../../components/header/custom_header.dart';
import '../../settings_page/rules_page.dart';
import '../../settings_page/settings_page.dart';

class JoinGamePage extends StatefulWidget {
  const JoinGamePage({super.key});

  @override
  State<JoinGamePage> createState() => _JoinGamePageState();
}

class _JoinGamePageState extends State<JoinGamePage> {
  static const double _headerHeight = 100;
  static const double _gapBelowHeader = 10;

  final List<Map<String, dynamic>> games = [
    {'title':'Partie 1','isPrivate':false,'maxPlayers':4,'currentPlayers':2,},
    {'title':'Partie 2','isPrivate':false,'maxPlayers':4,'currentPlayers':3,},
    {'title':'Partie 3','isPrivate':true,'maxPlayers':6,'currentPlayers':6,},
    {'title':'Partie 4','isPrivate':false,'maxPlayers':5,'currentPlayers':1,},
    {'title':'Partie 5','isPrivate':true,'maxPlayers':6,'currentPlayers':5,},
    {'title':'Partie 6','isPrivate':true,'maxPlayers':4,'currentPlayers':4,},
    {'title':'Partie 7','isPrivate':true,'maxPlayers':6,'currentPlayers':1,},
  ];

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
          // background
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
              left: 16,
              right: 16,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const SizedBox(
                    width: 48,
                    height: 48,
                    child: Image(
                      image: AssetImage("res/assets/join_game/back.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.only(right: 4),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 20,
                      childAspectRatio: 6,
                    ),
                    itemCount: games.length,
                    itemBuilder: (context, index) {
                      final game = games[index];
                      return JoinGameCard(
                        title: game['title'],
                        isPrivate: game['isPrivate'],
                        maxPlayers: game['maxPlayers'],
                        currentPlayers: game['currentPlayers'],
                        onTap: () {},
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
