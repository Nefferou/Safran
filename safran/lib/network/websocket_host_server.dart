import 'dart:io';
import 'dart:convert';

class WebSocketHostServer {
  HttpServer? _server;
  final List<WebSocket> _clients = [];

  Future<void> start({int port = 8080}) async {
    _server = await HttpServer.bind(InternetAddress.anyIPv4, port);
    print('🛰️ WebSocket server listening on port $port');

    _server!.listen((HttpRequest request) async {
      if (WebSocketTransformer.isUpgradeRequest(request)) {
        final socket = await WebSocketTransformer.upgrade(request);
        _clients.add(socket);
        print('✅ Nouveau client connecté');

        socket.listen(
              (data) => _onData(socket, data),
          onDone: () => _onDone(socket),
          onError: (e) => print('⚠️ Erreur WebSocket: $e'),
        );
      } else {
        request.response.statusCode = HttpStatus.badRequest;
        await request.response.close();
      }
    });
  }

  void _onData(WebSocket client, dynamic data) {
    print('📥 Message reçu : $data');
    // Echo pour test
    for (final c in _clients) {
      if (c != client) c.add(data);
    }
  }

  void _onDone(WebSocket client) {
    _clients.remove(client);
    print('❌ Client déconnecté');
  }

  void stop() {
    _server?.close();
    for (final client in _clients) {
      client.close();
    }
    print('🛑 WebSocket Server arrêté');
  }
}
