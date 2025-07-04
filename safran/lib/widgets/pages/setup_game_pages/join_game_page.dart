import 'package:flutter/material.dart';
import '../../../network/game_discovery.dart';
import '../../../network/websocket_client_connection.dart';
import 'lobby_page.dart';

class JoinGamePage extends StatefulWidget {
  const JoinGamePage({super.key});

  @override
  State<JoinGamePage> createState() => _JoinGamePageState();
}

class _JoinGamePageState extends State<JoinGamePage> {
  List<Map<String, dynamic>> games = [];
  final WebSocketClientConnection _connection = WebSocketClientConnection();
  late GameDiscovery discovery;

  @override
  void initState() {
    super.initState();
    discovery = GameDiscovery(onGameFound: (game) {
      if (mounted && !games.any((g) => g['ip'] == game['ip'])) {
        setState(() => games.add(game));
      }
    });
    discovery.startListening();
  }

  @override
  void dispose() {
    discovery.stopListening();
    super.dispose();
  }

  void connectToGame(Map<String, dynamic> game) {
    _connection.connect(game['ip']);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LobbyPage(
          isHost: false,
          playerIp: game['ip'],
          gameServer: null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rejoindre une partie")),
      body: ListView.builder(
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];
          return ListTile(
            title: Text(game['name']),
            subtitle: Text("${game['currentPlayers']}/${game['maxPlayers']} joueurs"),
            onTap: () => connectToGame(game),
          );
        },
      ),
    );
  }
}
