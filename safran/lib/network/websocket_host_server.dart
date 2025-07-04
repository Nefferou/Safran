import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'game_server.dart';

class WebSocketHostServer {
  HttpServer? _server;
  final List<_ClientInfo> _clients = [];
  GameServer? _gameServer;
  bool _isRunning = false;
  String? currentHostIp;

  void Function(String message)? onMessageReceived;

  void attachGameServer(GameServer server) {
    _gameServer = server;
  }

  Future<void> start() async {
    if (_isRunning) return;
    try {
      _server = await HttpServer.bind(InternetAddress.anyIPv4, 8080);
      _isRunning = true;
      print("🛰️ WebSocket server listening on port 8080");

      _server!.listen((HttpRequest request) async {
        if (!WebSocketTransformer.isUpgradeRequest(request)) {
          request.response.statusCode = HttpStatus.forbidden;
          await request.response.close();
          return;
        }

        final socket = await WebSocketTransformer.upgrade(request);
        final ip = request.connectionInfo?.remoteAddress.address ?? "unknown";

        print("🔌 Nouveau client connecté: $ip");

        final client = _ClientInfo(socket, ip);
        _clients.add(client);
        _gameServer?.playerJoined();

        if (currentHostIp == null) {
          currentHostIp = ip;
          print("👑 Hôte initial: $ip");
          socket.add(jsonEncode({"type": "promote_to_host"}));
        }

        socket.add(jsonEncode({"type": "welcome", "ip": ip}));
        broadcastPlayerList();

        socket.listen(
              (data) {
            print("📥 Message reçu de $ip: $data");
            if (onMessageReceived != null) onMessageReceived!(data);

            for (var c in _clients) {
              if (c.socket != socket) {
                c.socket.add(data);
              }
            }
          },
          onDone: () {
            print("❌ Déconnexion de $ip");
            _clients.removeWhere((c) => c.socket == socket);

            if (ip == currentHostIp) {
              if (_clients.isNotEmpty) {
                final newHost = _clients.first;
                currentHostIp = newHost.ip;
                newHost.socket.add(jsonEncode({"type": "promote_to_host"}));
                print("👑 Nouveau host: $currentHostIp");
              } else {
                stop();
                return;
              }
            }

            broadcastPlayerList();
          },
          onError: (error) {
            print("💥 Erreur WebSocket: $error");
            _clients.removeWhere((c) => c.socket == socket);
            broadcastPlayerList();
          },
        );
      });
    } catch (e) {
      print("❌ Erreur serveur WebSocket: $e");
      _isRunning = false;
    }
  }

  void broadcastPlayerList() {
    final players = _clients.map((c) => c.ip).toList();

    final message = jsonEncode({
      "type": "players_update",
      "players": players,
      "host": currentHostIp
    });

    for (var client in _clients) {
      client.socket.add(message);
    }
    print("📡 Mise à jour joueurs envoyée: $message");
  }

  void stop() {
    if (!_isRunning) return;

    _isRunning = false;
    for (var client in _clients) {
      client.socket.close();
    }
    _clients.clear();
    _server?.close();
    _server = null;
    currentHostIp = null;

    print("🛑 WebSocket Server arrêté");
  }
}

/// Structure interne pour stocker une socket avec son IP
class _ClientInfo {
  final WebSocket socket;
  final String ip;

  _ClientInfo(this.socket, this.ip);
}
