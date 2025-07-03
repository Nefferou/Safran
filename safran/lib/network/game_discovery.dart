import 'dart:io';
import 'dart:convert';

class GameDiscovery {
  final Function(Map<String, dynamic>) onGameFound;

  GameDiscovery({required this.onGameFound});

  void startListening() async {
    final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 4567);
    print("👂 Listening for games on port 4567...");

    socket.listen((RawSocketEvent event) {
      if (event == RawSocketEvent.read) {
        final datagram = socket.receive();
        if (datagram != null) {
          final data = utf8.decode(datagram.data);

          print("📨 Paquet reçu de ${datagram.address.address}: $data");

          try {
            final json = jsonDecode(data);
            if (json['type'] == 'announce') {
              onGameFound({
                "name": json['gameName'],
                "maxPlayers": json['maxPlayers'],
                "currentPlayers": json['currentPlayers'] ?? 1,
                "ip": datagram.address.address,
              });
            }
          } catch (e) {
            print("❌ Failed to parse JSON: $e");
          }
        }
      }
    });
  }
}