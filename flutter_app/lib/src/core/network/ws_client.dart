import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../config/app_config.dart';

class WsChatClient {
  WsChatClient(this._config);

  final AppConfig _config;
  WebSocket? _socket;
  final StreamController<Map<String, dynamic>> _messagesController =
      StreamController.broadcast();

  Stream<Map<String, dynamic>> get messages => _messagesController.stream;

  Future<void> connect(int contactId) async {
    await disconnect();
    _socket = await WebSocket.connect('${_config.websocketBase}/chat/$contactId');
    _socket!.listen(
      (dynamic data) {
        try {
          final decoded = jsonDecode(data as String);
          if (decoded is Map<String, dynamic>) {
            _messagesController.add(decoded);
          } else if (decoded is Map) {
            _messagesController.add(Map<String, dynamic>.from(decoded));
          }
        } catch (_) {
          _messagesController.add({
            'type': 'CHAT_MESSAGE',
            'message': data.toString(),
            'from': 'CUSTOMER',
          });
        }
      },
      onError: (Object error, StackTrace stackTrace) {
        _messagesController.add({
          'type': 'ERROR',
          'message': error.toString(),
        });
      },
    );
  }

  void sendChatMessage(String text) {
    final payload = {
      'type': 'CHAT_MESSAGE',
      'message': text,
      'from': 'COMPANY',
    };
    _socket?.add(jsonEncode(payload));
  }

  Future<void> disconnect() async {
    await _socket?.close();
    _socket = null;
  }

  Future<void> dispose() async {
    await disconnect();
    await _messagesController.close();
  }
}
