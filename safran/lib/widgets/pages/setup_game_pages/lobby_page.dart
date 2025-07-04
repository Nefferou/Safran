import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../network/game_server.dart';
import '../../../network/websocket_host_server.dart';

class LobbyPage extends StatefulWidget {
  final bool isHost;
  final String playerIp;
  final GameServer? gameServer;
  final WebSocketHostServer? wsServer;

  const LobbyPage({
    Key? key,
    required this.isHost,
    required this.playerIp,
    this.gameServer,
    this.wsServer,
  }) : super(key: key);

  @override
  State<LobbyPage> createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  List<String> players = [];
  bool _hasShutdown = false;
  late bool isHostLocal;

  @override
  void initState() {
    super.initState();
    isHostLocal = widget.isHost;

    widget.wsServer?.onMessage = (String message) {
      final data = jsonDecode(message);
      if (data['type'] == 'players_update') {
        setState(() {
          players = List<String>.from(data['players']);
        });
      }
      if (data['type'] == 'promote_to_host') {
        setState(() {
          isHostLocal = true;
        });
        print("👑 Ce client devient le nouveau host !");
      }
    };
  }

  Future<void> shutdownServersIfNeeded() async {
    if (_hasShutdown) return;
    _hasShutdown = true;

    if (isHostLocal) {
      widget.gameServer?.stop();
      widget.wsServer?.stop();
      print("🧼 Host a quitté, serveurs arrêtés.");
    }
  }

  Future<bool> _onWillPop() async {
    await shutdownServersIfNeeded();
    Navigator.pop(context);
    return false;
  }

  @override
  void dispose() {
    shutdownServersIfNeeded();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(title: Text("Lobby")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text("🧑 Joueurs connectés", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("IP: ${widget.playerIp}", style: TextStyle(fontSize: 16)),
              if (isHostLocal)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("(vous êtes l’hôte)", style: TextStyle(color: Colors.grey)),
                ),
              Expanded(
                child: ListView.builder(
                  itemCount: players.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(players[index]),
                      leading: Icon(Icons.person),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}