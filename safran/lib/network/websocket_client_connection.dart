import 'dart:io';

class WebSocketClientConnection {
  WebSocket? _socket;
  void Function(String)? onMessageReceived;

  Future<void> connect(String ip) async {
    try {
      _socket = await WebSocket.connect('ws://$ip:8080');
      print("🔌 Connecté à $ip");

      _socket!.listen(
            (data) {
          print("📥 Message reçu: $data");
          if (onMessageReceived != null) {
            onMessageReceived!(data);
          }
        },
        onDone: () {
          print("❌ Déconnecté du serveur WebSocket");
        },
        onError: (e) {
          print("💥 Erreur WebSocket: $e");
        },
      );
    } catch (e) {
      print("❌ Échec de la connexion WebSocket: $e");
    }
  }

  void send(String message) {
    _socket?.add(message);
  }

  void close() {
    _socket?.close();
    print("🛑 Connexion WebSocket fermée");
  }
}
