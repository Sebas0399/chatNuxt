import 'dart:async';

import 'package:flutter/foundation.dart';

import 'network/api_client.dart';
import 'network/ws_client.dart';

class AppState extends ChangeNotifier {
  AppState({required ApiClient apiClient, required WsChatClient wsChatClient})
      : _apiClient = apiClient,
        _wsChatClient = wsChatClient {
    _subscription = _wsChatClient.messages.listen(_onSocketMessage);
  }

  final ApiClient _apiClient;
  final WsChatClient _wsChatClient;
  StreamSubscription<Map<String, dynamic>>? _subscription;

  bool isLoading = false;
  String? error;

  List<Map<String, dynamic>> botTypes = const [];
  List<Map<String, dynamic>> botsByType = const [];
  String? selectedBotType;

  List<Map<String, dynamic>> contacts = const [];
  List<Map<String, dynamic>> messages = const [];
  Map<String, dynamic>? selectedContact;

  Future<void> loadBotTypes() async {
    await _run(() async {
      botTypes = await _apiClient.getBotTypes();
      if (selectedBotType == null && botTypes.isNotEmpty) {
        selectedBotType = botTypes.first['name']?.toString();
      }
    });
    if (selectedBotType != null) {
      await loadBotsByType(selectedBotType!);
    }
  }

  Future<void> loadBotsByType(String type) async {
    selectedBotType = type;
    await _run(() async {
      botsByType = await _apiClient.getBotsByType(type);
    });
  }

  Future<void> loadContacts({int companyId = 1}) async {
    await _run(() async {
      contacts = await _apiClient.getContactsByCompany(companyId);
    });
  }

  Future<void> selectContact(Map<String, dynamic> contact) async {
    selectedContact = contact;
    final contactId = _toInt(contact['id']);
    await _run(() async {
      messages = await _apiClient.getMessagesByContact(contactId);
      await _wsChatClient.connect(contactId);
    });
  }

  void sendMessage(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    _wsChatClient.sendChatMessage(trimmed);
    final optimistic = {
      'id': messages.length + 1,
      'text': trimmed,
      'from': 'COMPANY',
      'createdAt': DateTime.now().toIso8601String(),
    };
    messages = [...messages, optimistic];
    notifyListeners();
  }

  Future<void> _run(Future<void> Function() action) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      await action();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void _onSocketMessage(Map<String, dynamic> payload) {
    if (payload['type'] != 'CHAT_MESSAGE') return;
    messages = [
      ...messages,
      {
        'id': messages.length + 1,
        'text': payload['message']?.toString() ?? '',
        'from': payload['from']?.toString() ?? 'CUSTOMER',
      },
    ];
    notifyListeners();
  }

  int _toInt(Object? value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  @override
  void dispose() {
    unawaited(_subscription?.cancel());
    unawaited(_wsChatClient.dispose());
    super.dispose();
  }
}
