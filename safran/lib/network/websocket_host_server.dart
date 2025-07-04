import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'game_server.dart';

class WebSocketHostServer {
  HttpServer? _server;
  final List<WebSocket> _clients = [];
  GameServer? _gameServer;
  bool _isRunning = false;
  String? currentHostIp;

  Function(String message)? onMessage;

  void attachGameServer(GameServer server) {
    _gameServer = server;
  }

  Future<void> start() async {
    if (_isRunning) {
      print("⚠️ WebSocketHostServer déjà en cours d'exécution.");
      return;
    }

    try {
      _server = await HttpServer.bind(InternetAddress.anyIPv4, 8080);
      _isRunning = true;
      print("🛰️ WebSocket server listening on port 8080");

      _server!.listen((HttpRequest request) async {
        if (WebSocketTransformer.isUpgradeRequest(request)) {
          final socket = await WebSocketTransformer.upgrade(request);
          final ip = request.connectionInfo?.remoteAddress.address ?? "unknown";
          print("🔌 Nouveau client WebSocket connecté: $ip");

          _clients.add(socket);
          _gameServer?.playerJoined();
          if (currentHostIp == null) currentHostIp = ip;

          socket.add(jsonEncode({"type": "welcome", "ip": ip}));

          broadcastPlayerList();

          socket.listen(
                (data) {
              print("📥 Message reçu du client: $data");
              if (onMessage != null) onMessage!(data);
              for (var client in _clients) {
                if (client != socket) {
                  client.add(data);
                }
              }
            },
            onDone: () {
              print("❌ Client déconnecté: $ip");
              _clients.remove(socket);

              if (_clients.isNotEmpty && ip == currentHostIp) {
                final newHost = _clients.first;
                currentHostIp = "unknown";
                newHost.add(jsonEncode({"type": "promote_to_host"}));
                print("👑 Promotion du nouveau host");
              }

              if (_clients.isEmpty) {
                stop();
              }

              broadcastPlayerList();
            },
            onError: (e) {
              print("💥 Erreur WebSocket: $e");
              _clients.remove(socket);
              broadcastPlayerList();
            },
          );
        } else {
          request.response.statusCode = HttpStatus.forbidden;
          await request.response.close();
        }
      });
    } catch (e) {
      print("❌ WebSocket Server failed to start: $e");
    }
  }

  void broadcastPlayerList() {
    final message = jsonEncode({
      "type": "players_update",
      "players": _clients.map((_) => _.hashCode.toString()).toList(),
    });
    for (var client in _clients) {
      client.add(message);
    }
  }

  void stop() {
    if (!_isRunning) {
      print("⚠️ WebSocketHostServer déjà arrêté.");
      return;
    }

    _isRunning = false;
    for (var client in _clients) {
      client.close();
    }
    _clients.clear();
    _server?.close();
    print("🛑 WebSocket Server arrêté");
  }
}
