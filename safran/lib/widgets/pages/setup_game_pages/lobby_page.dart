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
  List<String> _players = [];
  late bool _isHost;
  bool _hasShutdown = false;

  @override
  void initState() {
    super.initState();
    _isHost = widget.isHost;

    // Ajoute soi-même à la liste au démarrage
    _players.add(widget.playerIp);

    // Attache le handler de message
    widget.wsServer?.onMessageReceived = _handleMessageFromServer;
  }

  void _handleMessageFromServer(String message) {
    final data = jsonDecode(message);

    if (data['type'] == 'players_update') {
      setState(() {
        _players = List<String>.from(data['players']);
      });
    }

    if (data['type'] == 'promote_to_host') {
      setState(() {
        _isHost = true;
      });
      print("👑 Ce client devient le nouveau host !");
    }
  }

  Future<void> shutdownServersIfNeeded() async {
    if (_hasShutdown) return;
    _hasShutdown = true;

    if (_isHost) {
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
    widget.wsServer?.onMessageReceived = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(title: const Text("Lobby")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Text("Votre IP : ${widget.playerIp}", style: const TextStyle(fontSize: 16)),
              if (_isHost)
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text("(vous êtes l’hôte)", style: TextStyle(color: Colors.grey)),
                ),
              const SizedBox(height: 24),
              const Text("🧑 Joueurs connectés",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: _players.length,
                  itemBuilder: (context, index) {
                    final ip = _players[index];
                    final isMe = ip == widget.playerIp;
                    return ListTile(
                      title: Text(ip),
                      trailing: isMe ? const Text("Moi") : null,
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
