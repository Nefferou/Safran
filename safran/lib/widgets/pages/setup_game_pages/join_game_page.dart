import 'package:flutter/material.dart';
import '../../../network/game_discovery.dart';
import '../../../network/websocket_client_connection.dart';

class JoinGamePage extends StatefulWidget {
  @override
  _JoinGamePageState createState() => _JoinGamePageState();
}

class _JoinGamePageState extends State<JoinGamePage> {
  List<Map<String, dynamic>> games = [];
  final _connection = WebSocketClientConnection();

  @override
  void initState() {
    super.initState();
    final discovery = GameDiscovery(onGameFound: (game) {
      setState(() {
        if (!games.any((g) => g['ip'] == game['ip'])) {
          games.add(game);
        }
      });
    });
    discovery.startListening();
  }

  void connectToGame(String ip) {
    _connection.connect(ip);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rejoindre une partie")),
      body: ListView.builder(
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];
          return ListTile(
            title: Text(game['name']),
            subtitle: Text("Max joueurs : ${game['maxPlayers']}"),
            onTap: () => connectToGame(game['ip']),
          );
        },
      ),
    );
  }
}