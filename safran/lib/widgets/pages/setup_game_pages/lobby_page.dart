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
  String? _hostIp;
  late bool _isHost;
  bool _hasShutdown = false;

  @override
  void initState() {
    super.initState();
    _isHost = widget.isHost;
    _players = [widget.playerIp];

    widget.wsServer?.onMessageReceived = _handleMessageFromServer;
  }

  void _handleMessageFromServer(String message) {
    final data = jsonDecode(message);

    if (data['type'] == 'players_update') {
      final newPlayers = List<String>.from(data['players']);
      final newHost = data['host'] as String?;

      setState(() {
        _players = newPlayers;
        _hostIp = newHost;
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
    List<String> sortedPlayers = [..._players];
    if (_hostIp != null && sortedPlayers.contains(_hostIp)) {
      sortedPlayers.remove(_hostIp);
      sortedPlayers.insert(0, _hostIp!);
    }

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
                  itemCount: sortedPlayers.length,
                  itemBuilder: (context, index) {
                    final ip = sortedPlayers[index];
                    final isMe = ip == widget.playerIp;
                    final isHost = ip == _hostIp;

                    return ListTile(
                      title: Text(ip),
                      subtitle: isHost
                          ? isMe
                          ? const Text("👑 Vous êtes l’hôte", style: TextStyle(color: Colors.orange))
                          : const Text("👑 Hôte", style: TextStyle(color: Colors.orange))
                          : isMe
                          ? const Text("Vous", style: TextStyle(color: Colors.grey))
                          : null,
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
