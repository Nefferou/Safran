import 'package:flutter/material.dart';

import '../../../network/game_server.dart';
import '../../../network/websocket_host_server.dart';

class HostGamePage extends StatefulWidget {
  @override
  _HostGamePageState createState() => _HostGamePageState();
}

class _HostGamePageState extends State<HostGamePage> {
  String gameName = '';
  int maxPlayers = 3;
  GameServer? _gameServer;
  WebSocketHostServer? _wsServer;

  void startHost() async {
    _gameServer = GameServer(gameName: gameName, maxPlayers: maxPlayers);
    await _gameServer!.start();

    _wsServer = WebSocketHostServer();
    await _wsServer!.start();
  }

  @override
  void dispose() {
    _gameServer?.stop();
    _wsServer?.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Créer une partie")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Nom de la partie"),
              onChanged: (val) => setState(() => gameName = val),
            ),
            SizedBox(height: 10),
            DropdownButton<int>(
              value: maxPlayers,
              onChanged: (val) => setState(() => maxPlayers = val!),
              items: [3, 4, 5, 6]
                  .map((v) => DropdownMenuItem(value: v, child: Text('$v joueurs')))
                  .toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: gameName.isNotEmpty ? startHost : null,
              child: Text("Lancer la partie"),
            ),
          ],
        ),
      ),
    );
  }
}
