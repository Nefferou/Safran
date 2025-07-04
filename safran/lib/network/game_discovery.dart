import 'dart:io';
import 'dart:convert';

class GameDiscovery {
  final Function(Map<String, dynamic>) onGameFound;
  RawDatagramSocket? _socket;

  GameDiscovery({required this.onGameFound});

  void startListening() async {
    _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 4567);
    print("👂 Listening for games on port 4567...");

    _socket!.listen((RawSocketEvent event) {
      if (event == RawSocketEvent.read) {
        final datagram = _socket!.receive();
        if (datagram != null) {
          final data = utf8.decode(datagram.data);
          print("📨 Paquet reçu de \${datagram.address.address}: \$data");
          try {
            final json = jsonDecode(data);
            if (json['type'] == 'announce') {
              print("✅ Partie détectée: \${json['gameName']} (\${json['currentPlayers']}/\${json['maxPlayers']})");
              onGameFound({
                "name": json['gameName'],
                "maxPlayers": json['maxPlayers'],
                "currentPlayers": json['currentPlayers'] ?? 1,
                "ip": datagram.address.address,
              });
            } else {
              print("⚠️ Type inconnu: \${json['type']}");
            }
          } catch (e) {
            print("❌ Failed to parse JSON: \$e");
          }
        }
      }
    });
  }

  void stopListening() {
    _socket?.close();
    print("🛑 Stopped listening for games");
  }
}
