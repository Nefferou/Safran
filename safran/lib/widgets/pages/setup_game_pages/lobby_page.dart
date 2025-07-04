import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../network/game_server.dart';
import '../../../network/websocket_client_connection.dart';

class LobbyPage extends StatefulWidget {
  final bool isHost;
  final String playerIp;
  final GameServer? gameServer;

  const LobbyPage({
    Key? key,
    required this.isHost,
    required this.playerIp,
    this.gameServer,
  }) : super(key: key);

  @override
  State<LobbyPage> createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  late final WebSocketClientConnection _clientConnection;
  List<String> _players = [];
  late bool _isHost;
  bool _hasShutdown = false;

  @override
  void initState() {
    super.initState();
    _isHost = widget.isHost;
    _clientConnection = WebSocketClientConnection();

    // Se connecter au serveur WebSocket
    _clientConnection.connect(widget.playerIp);
    _clientConnection.onMessageReceived = _handleMessage;
  }

  void _handleMessage(String message) {
    final data = jsonDecode(message);

    if (data['type'] == 'players_update') {
      setState(() {
        _players = List<String>.from(data['players']);
      });
    } else if (data['type'] == 'promote_to_host') {
      setState(() {
        _isHost = true;
      });
      print("👑 Vous êtes maintenant l'hôte !");
    }
  }

  Future<void> shutdownServersIfNeeded() async {
    if (_hasShutdown) return;
    _hasShutdown = true;

    _clientConnection.close();
    if (_isHost) {
      widget.gameServer?.stop();
      print("🧼 Hôte a quitté. Serveur arrêté.");
    }
  }

  @override
  void dispose() {
    shutdownServersIfNeeded();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await shutdownServersIfNeeded();
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Lobby')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Votre IP: ${widget.playerIp}"),
              const SizedBox(height: 12),
              if (_isHost)
                const Text("(Vous êtes l'hôte)", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 24),
              const Text("Joueurs connectés:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Expanded(
                child: ListView.builder(
                  itemCount: _players.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(_players[index]),
                    trailing: _players[index] == widget.playerIp ? const Text("Moi") : null,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
