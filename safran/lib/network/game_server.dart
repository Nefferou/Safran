import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:typed_data';

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
    print("🛠 Socket créée et broadcast activé");

    final interfaces = await NetworkInterface.list(type: InternetAddressType.IPv4);
    for (var iface in interfaces) {
      for (var addr in iface.addresses) {
        if (!addr.isLoopback) {
          final broadcast = getBroadcastAddress(addr, InternetAddress("255.255.255.0")); // Assumes /24 subnet
          print('📡 Interface utilisée: ${iface.name} — IP: ${addr.address} → Broadcast: ${broadcast.address}');

          _broadcastTimer = Timer.periodic(Duration(seconds: 2), (timer) {
            final message = jsonEncode({
              "type": "announce",
              "gameName": gameName,
              "maxPlayers": maxPlayers,
              "currentPlayers": currentPlayers
            });

            _socket!.send(
              utf8.encode(message),
              broadcast,
              4567,
            );
            print("📣 Message broadcasté sur ${broadcast.address}:4567");
          });
          break; // Use the first valid interface
        }
      }
    }

    print("🔊 Server started and broadcasting on UDP port 4567...");
  }

  InternetAddress getBroadcastAddress(InternetAddress ip, InternetAddress subnetMask) {
    final ipBytes = ip.rawAddress;
    final maskBytes = subnetMask.rawAddress;
    final broadcastBytes = List<int>.generate(4, (i) => ipBytes[i] | (~maskBytes[i] & 0xFF));
    return InternetAddress.fromRawAddress(Uint8List.fromList(broadcastBytes));
  }

  void playerJoined() {
    if (currentPlayers < maxPlayers) {
      currentPlayers++;
      print("👤 Nouveau joueur rejoint. Total: $currentPlayers/$maxPlayers");
    }
  }

  void stop() {
    _broadcastTimer?.cancel();
    _socket?.close();
    print("🛑 Server stopped");
  }
}