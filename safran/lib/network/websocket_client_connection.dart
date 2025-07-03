import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class WebSocketClientConnection {
  late IOWebSocketChannel _channel;

  void connect(String ip, {int port = 8080}) {
    final url = 'ws://$ip:$port';
    print('🔌 Connexion à $url');
    _channel = IOWebSocketChannel.connect(url);

    _channel.stream.listen(
          (data) => print('📨 Message du serveur : $data'),
      onDone: () => print('🚪 Connexion fermée'),
      onError: (e) => print('⚠️ Erreur de connexion : $e'),
    );

    // Exemple d'envoi
    _channel.sink.add('Hello depuis le client');
  }

  void send(String message) {
    _channel.sink.add(message);
  }

  void disconnect() {
    _channel.sink.close(status.goingAway);
  }
}