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

  /// ✅ Callback externe que la page Lobby peut assigner
  void Function(String message)? onMessageReceived;

  void attachGameServer(GameServer server) {
    _gameServer = server;
  }

  Future<void> start() async {
    if (_isRunning) {
      print("⚠️ WebSocketHostServer déjà en cours.");
      return;
    }

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

        _clients.add(socket);
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

            // ✅ Appeler la fonction côté UI si définie
            if (onMessageReceived != null) {
              onMessageReceived!(data);
            }

            // Propager aux autres clients
            for (var client in _clients) {
              if (client != socket) {
                client.add(data);
              }
            }
          },
          onDone: () {
            print("❌ Déconnexion de $ip");
            _clients.remove(socket);

            if (ip == currentHostIp) {
              if (_clients.isNotEmpty) {
                final newHost = _clients.first;
                currentHostIp = newHost.closeCode?.toString() ?? "unknown";
                newHost.add(jsonEncode({"type": "promote_to_host"}));
                print("👑 Nouveau host: $currentHostIp");
              } else {
                print("🧼 Dernier joueur quitté, arrêt serveur");
                stop();
                return;
              }
            }

            broadcastPlayerList();
          },
          onError: (error) {
            print("💥 Erreur WebSocket: $error");
            _clients.remove(socket);
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
    final message = jsonEncode({
      "type": "players_update",
      "players": _clients.map((_) => "Client").toList() // Remplace par de vraies IP si possible
    });
    for (var client in _clients) {
      client.add(message);
    }
    print("📡 Mise à jour joueurs envoyée");
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
    _server = null;
    currentHostIp = null;

    print("🛑 WebSocket Server arrêté");
  }
}
