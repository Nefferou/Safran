import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:typed_data';

class GameServer {
  final String gameName;
  final int maxPlayers;
  RawDatagramSocket? _socket;
  final List<Timer> _broadcastTimers = [];
  int currentPlayers = 1;
  bool _isRunning = false;

  GameServer({required this.gameName, required this.maxPlayers});

  Future<void> start() async {
    if (_isRunning) return;
    _isRunning = true;

    _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 4567);
    _socket!.broadcastEnabled = true;
    print("🛠 Socket créée et broadcast activé");

    final interfaces = await NetworkInterface.list(type: InternetAddressType.IPv4);
    for (var iface in interfaces) {
      for (var addr in iface.addresses) {
        if (!addr.isLoopback) {
          final broadcast = getBroadcastAddress(addr, InternetAddress("255.255.255.0"));
          print('📡 Interface utilisée: ${iface.name} — IP: ${addr.address} → Broadcast: ${broadcast.address}');

          final timer = Timer.periodic(Duration(seconds: 2), (timer) {
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
            // print("📣 Message broadcasté sur ${broadcast.address}:4567");
          });

          _broadcastTimers.add(timer);
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
    if (!_isRunning) return;
    _isRunning = false;

    for (final timer in _broadcastTimers) {
      timer.cancel();
    }
    _broadcastTimers.clear();

    _socket?.close();

    print("🛑 Server stopped");
  }
}