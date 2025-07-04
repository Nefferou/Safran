import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'game_server.dart';

class WebSocketHostServer {
  HttpServer? _server;
  final List<WebSocket> _clients = [];
  final Map<WebSocket, String> _clientIps = {};
  GameServer? _gameServer;
  bool _isRunning = false;
  String? currentHostIp;

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
        print("🔌 Client connecté: $ip");

        _clients.add(socket);
        _clientIps[socket] = ip;
        _gameServer?.playerJoined();

        if (currentHostIp == null) {
          currentHostIp = ip;
          print("👑 Hôte initial: $ip");
          socket.add(jsonEncode({"type": "promote_to_host"}));
        }

        socket.add(jsonEncode({"type": "welcome", "ip": ip}));
        _broadcastPlayerList();

        socket.listen(
              (data) {
            print("📥 Message reçu de $ip: $data");
            // Broadcast aux autres clients
            for (var client in _clients) {
              if (client != socket) {
                client.add(data);
              }
            }
          },
          onDone: () => _handleDisconnect(socket),
          onError: (error) {
            print("💥 Erreur WebSocket avec $ip: $error");
            _handleDisconnect(socket);
          },
        );
      });
    } catch (e) {
      print("❌ Erreur serveur WebSocket: $e");
      _isRunning = false;
    }
  }

  void _handleDisconnect(WebSocket socket) {
    final ip = _clientIps[socket] ?? "unknown";
    print("❌ Client déconnecté: $ip");

    _clients.remove(socket);
    _clientIps.remove(socket);

    if (ip == currentHostIp) {
      if (_clients.isNotEmpty) {
        final newHost = _clients.first;
        currentHostIp = _clientIps[newHost] ?? "unknown";
        newHost.add(jsonEncode({"type": "promote_to_host"}));
        print("👑 Nouveau hôte: $currentHostIp");
      } else {
        print("🧼 Tous les joueurs sont partis, arrêt du serveur");
        stop();
        return;
      }
    }

    _broadcastPlayerList();
  }

  void _broadcastPlayerList() {
    final ips = _clients.map((c) => _clientIps[c] ?? "unknown").toList();
    final message = jsonEncode({"type": "players_update", "players": ips});
    for (var client in _clients) {
      client.add(message);
    }
    print("📡 Mise à jour joueurs: $ips");
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
    _clientIps.clear();
    _server?.close();
    _server = null;
    currentHostIp = null;

    print("🛑 WebSocket Server arrêté");
  }
}
