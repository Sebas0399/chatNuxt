import 'package:flutter/foundation.dart';

import '../network/api_client.dart';
import 'session_store.dart';

class AuthController extends ChangeNotifier {
  AuthController({required ApiClient apiClient, required SessionStore sessionStore})
      : _apiClient = apiClient,
        _sessionStore = sessionStore;

  final ApiClient _apiClient;
  final SessionStore _sessionStore;

  String? _token;
  String? _username;
  bool _isLoading = false;
  String? _error;

  String? get token => _token;
  String? get username => _username;
  bool get isAuthenticated => _token != null && _token!.isNotEmpty;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadSession() async {
    final session = await _sessionStore.load();
    _token = session?['token'] as String?;
    _username = session?['username'] as String?;
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    _setLoading(true);
    _error = null;
    try {
      final token = await _apiClient.login(username: username, password: password);
      _token = token;
      _username = username;
      await _sessionStore.save(token: token, username: username);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    _token = null;
    _username = null;
    await _sessionStore.clear();
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
