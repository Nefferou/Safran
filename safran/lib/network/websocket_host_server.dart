import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'game_server.dart';

class WebSocketHostServer {
  HttpServer? _server;
  final List<WebSocket> _clients = [];
  final Map<WebSocket, String> _clientIps = {};
  GameServer? _gameServer;
  BuildContext? _context;
  bool _isRunning = false;
  String? currentHostIp;

  void attachGameServer(GameServer server) {
    _gameServer = server;
  }

  void attachContext(BuildContext context) {
    _context = context;
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

          if (_clientIps.containsValue(ip)) {
            print("🚫 Client avec IP $ip déjà connecté.");
            return;
          }

          _clients.add(socket);
          _clientIps[socket] = ip;
          _gameServer?.playerJoined();

          currentHostIp ??= ip;

          socket.add(jsonEncode({"type": "welcome", "ip": ip}));
          broadcastPlayerList();

          socket.listen(
            (data) {
              print("📥 Message reçu du client: $data");
              for (var client in _clients) {
                if (client != socket) {
                  client.add(data);
                }
              }
            },
            onDone: () {
              print("❌ Client déconnecté: $ip");
              _clients.remove(socket);
              _clientIps.remove(socket);

              if (ip == currentHostIp && _clients.isNotEmpty) {
                final newHost = _clients.first;
                final newHostIp = _clientIps[newHost];
                if (newHostIp != null) {
                  currentHostIp = newHostIp;
                  newHost.add(jsonEncode({"type": "promote_to_host"}));
                  print("👑 Promotion du nouveau host: $newHostIp");
                }
              }

              broadcastPlayerList();

              if (_clients.isEmpty) {
                print("🧹 Plus aucun joueur, arrêt du serveur.");
                stop();
              }
            },
            onError: (e) {
              print("💥 Erreur WebSocket: $e");
              _clients.remove(socket);
              _clientIps.remove(socket);
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
    final ips = _clientIps.values.toList();
    final message = jsonEncode({"type": "players_update", "players": ips});
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
    _clientIps.clear();
    _server?.close();
    print("🛑 WebSocket Server arrêté");
  }
}
