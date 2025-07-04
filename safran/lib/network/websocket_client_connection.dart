import 'dart:io';

class WebSocketClientConnection {
  WebSocket? _socket;
  bool isConnected = false;

  void connect(String ip) async {
    if (isConnected) {
      print("🔁 Déjà connecté à $ip, annulation de la reconnexion.");
      return;
    }


    try {
      _socket = await WebSocket.connect("ws://$ip:8080");
      isConnected = true;
      print("✅ Connecté à $ip");

      _socket!.listen(
            (data) => print("📩 Message reçu: $data"),





        onDone: () {
          print("🛑 Déconnecté");
          isConnected = false;
        },
        onError: (e) {
          print("❌ Erreur WebSocket: $e");
          isConnected = false;
        },
      );
    } catch (e) {
      print("❌ Échec de connexion à $ip: $e");
      isConnected = false;
    }
  }

  void disconnect() {




    _socket?.close();
    isConnected = false;
  }
}