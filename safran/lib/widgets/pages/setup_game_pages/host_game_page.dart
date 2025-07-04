import 'dart:io';
import 'package:flutter/material.dart';
import '../../../network/game_server.dart';
import '../../../network/websocket_host_server.dart';
import 'lobby_page.dart';

class HostGamePage extends StatefulWidget {
  const HostGamePage({super.key});

  @override
  State<HostGamePage> createState() => _HostGamePageState();
}

class _HostGamePageState extends State<HostGamePage> {
  String gameName = '';
  int maxPlayers = 3;
  GameServer? _gameServer;
  WebSocketHostServer? _wsServer;
  final TextEditingController _nameController = TextEditingController();
  bool _isStarting = false;

  void startHost() async {
    if (_isStarting) return;
    setState(() => _isStarting = true);

    try {
      _gameServer = GameServer(gameName: gameName, maxPlayers: maxPlayers);
      await _gameServer!.start();

      _wsServer = WebSocketHostServer();
      _wsServer!.attachGameServer(_gameServer!);
      await _wsServer!.start();

      final interfaces = await NetworkInterface.list(type: InternetAddressType.IPv4);
      final hostIp = interfaces
          .expand((iface) => iface.addresses)
          .firstWhere((addr) => !addr.isLoopback)
          .address;

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => LobbyPage(
            isHost: true,
            playerIp: hostIp,
            gameServer: _gameServer,
          ),
        ),
      );

      setState(() {
        gameName = '';
        maxPlayers = 3;
        _gameServer = null;
        _wsServer = null;
        _nameController.clear();
        _isStarting = false;
      });
    } catch (e) {
      print("🚨 Erreur dans startHost: $e");
      _gameServer?.stop();
      _wsServer?.stop();
      setState(() => _isStarting = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Créer une partie")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("Nom de la partie"),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: "Nom de la partie"),
            onChanged: (val) => setState(() => gameName = val),
          ),
          const SizedBox(height: 20),
          const Text("Nombre de joueurs max"),
          DropdownButton<int>(
            value: maxPlayers,
            onChanged: (val) => setState(() => maxPlayers = val!),
            items: [3, 4, 5, 6]
                .map((v) => DropdownMenuItem(value: v, child: Text('$v joueurs')))
                .toList(),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isStarting ? null : startHost,
            child: const Text("Lancer la partie"),
          ),
        ],
      ),
    );
  }
}
