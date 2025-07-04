import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'game_server.dart';

class WebSocketHostServer {
  HttpServer? _server;
  final List<WebSocket> _clients = [];
  GameServer? _gameServer;
  BuildContext? _context;

  bool _isRunning = false;
  Future<void>? _startupFuture;

  void attachGameServer(GameServer server) {
    _gameServer = server;
  }

  void attachContext(BuildContext context) {
    _context = context;
  }

  Future<void> start() async {
    // Déjà en cours d'exécution ou en train de démarrer
    if (_isRunning) {
      print("⚠️ WebSocketHostServer déjà en cours d'exécution.");
      return;
    }
    if (_startupFuture != null) {
      print("⚠️ WebSocketHostServer en cours de démarrage...");
      return _startupFuture;
    }

    _startupFuture = _startInternal();
    return _startupFuture;
  }

  Future<void> _startInternal() async {
    try {
      _server = await HttpServer.bind(InternetAddress.anyIPv4, 8080);
      _isRunning = true;
      print("🛰️ WebSocket server listening on port 8080");

      _server!.listen((HttpRequest request) async {
        if (WebSocketTransformer.isUpgradeRequest(request)) {
          final socket = await WebSocketTransformer.upgrade(request);
          final ip = request.connectionInfo?.remoteAddress.address ?? "unknown";
          print("🔌 Nouveau client WebSocket connecté: $ip");

          // Empêche les duplicatas (si nécessaire par IP ou autre logique plus robuste)
          if (_clients.any((c) => c.hashCode == socket.hashCode)) {
            print("🚫 Client déjà connecté.");
            return;
          }

          _clients.add(socket);
          _gameServer?.playerJoined();

          socket.add(jsonEncode({"type": "welcome", "ip": ip}));

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
            },
            onError: (e) {
              print("💥 Erreur WebSocket: $e");
              _clients.remove(socket);
            },
          );
        } else {
          request.response.statusCode = HttpStatus.forbidden;
          await request.response.close();
        }
      });
    } catch (e) {
      print("❌ WebSocket Server failed to start: $e");
      stop(); // clean partial failure
    } finally {
      _startupFuture = null; // libère le verrou pour futurs redémarrages si nécessaire
    }
  }

  void stop() {
    if (!_isRunning) {
      print("⚠️ WebSocketHostServer déjà arrêté.");
      return;
    }

    _isRunning = false;

    try {
      for (var client in _clients) {
        client.close();
      }
      _clients.clear();
      _server?.close(force: true);
      _server = null;
      print("🛑 WebSocket Server arrêté");
    } catch (e) {
      print("⚠️ Erreur lors de l'arrêt du WebSocket server: $e");
    }
  }
}
