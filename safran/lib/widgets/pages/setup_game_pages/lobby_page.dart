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
  bool isHost = false;

  @override
  void initState() {
    super.initState();
    isHost = widget.isHost;

    widget.wsServer?.onMessage = (String message) {
      final data = jsonDecode(message);
      if (data['type'] == 'players_update') {
        setState(() {
          players = List<String>.from(data['players']);
        });
      }
      if (data['type'] == 'promote_to_host') {
        setState(() {
          isHost = true;
        });
        print("👑 Ce client devient le nouveau host !");
      }
    };
  }

  Future<void> shutdownServersIfNeeded() async {
    if (_hasShutdown) return;
    _hasShutdown = true;

    if (isHost && widget.wsServer != null && widget.gameServer != null) {
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("🧑 Joueurs connectés", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("Votre IP: ${widget.playerIp}", style: TextStyle(fontSize: 16)),
              if (isHost)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text("(vous êtes l’hôte)", style: TextStyle(color: Colors.grey)),
                ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: players.length,
                  itemBuilder: (context, index) {
                    final ip = players[index];
                    return ListTile(
                      title: Text(ip),
                      leading: Icon(ip == widget.playerIp ? Icons.person : Icons.person_outline),
                      subtitle: ip == widget.playerIp && isHost ? Text("Moi (Hôte)") : null,
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
