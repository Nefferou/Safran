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
  final List<String> players = [];
  bool _hasShutdown = false;

  @override
  void initState() {
    super.initState();
    players.add(widget.playerIp);
  }

  Future<void> shutdownServersIfNeeded() async {
    if (_hasShutdown) return;
    _hasShutdown = true;

    if (widget.isHost) {
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
    shutdownServersIfNeeded(); // Sécurité en cas de destruction
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
              if (widget.isHost)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("(vous êtes l’hôte)", style: TextStyle(color: Colors.grey)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}