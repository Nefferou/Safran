import 'dart:io';
import 'dart:convert';
import 'dart:async';

class GameServer {
  final String gameName;
  final int maxPlayers;
  RawDatagramSocket? _socket;
  Timer? _broadcastTimer;
  int currentPlayers = 1;

  GameServer({required this.gameName, required this.maxPlayers});

  Future<void> start() async {
    _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 4567);
    _socket!.broadcastEnabled = true;

    _broadcastTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      final message = jsonEncode({
        "type": "announce",
        "gameName": gameName,
        "maxPlayers": maxPlayers,
        "currentPlayers": currentPlayers
      });

      _socket!.send(
        utf8.encode(message),
        InternetAddress("255.255.255.255"),
        4567,
      );
    });

    print("🔊 Server started and broadcasting on UDP port 4567...");

    final interfaces = await NetworkInterface.list();
    for (var iface in interfaces) {
      for (var addr in iface.addresses) {
        if (addr.type == InternetAddressType.IPv4 && !addr.isLoopback) {
          print('📡 Host IP: ${addr.address}');
        }
      }
    }
  }

  void playerJoined() {
    if (currentPlayers < maxPlayers) {
      currentPlayers++;
      print("👤 Nouveau joueur rejoint. Total: \$currentPlayers/\$maxPlayers");
    }
  }

  void stop() {
    _broadcastTimer?.cancel();
    _socket?.close();
    print("🛑 Server stopped");
  }
}
