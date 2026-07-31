import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';

class ApiClient {
  ApiClient(this._config);

  final AppConfig _config;
  final http.Client _httpClient = http.Client();

  Uri _uri(String path) {
    final base = Uri.parse(_config.apiBase);
    return base.replace(path: '${base.path}$path');
  }

  Future<String> login({required String username, required String password}) async {
    final response = await _httpClient.post(
      _uri('/companies/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        return jsonDecode(response.body) as String;
      } catch (_) {
        return response.body;
      }
    }

    throw Exception('Login failed: ${response.statusCode} ${response.body}');
  }

  Future<List<Map<String, dynamic>>> getBotTypes() => _getList('/botTypes');

  Future<List<Map<String, dynamic>>> getBotsByType(String type) =>
      _getList('/bots/$type');

  Future<List<Map<String, dynamic>>> getContactsByCompany(int companyId) =>
      _getList('/contacts/company/$companyId');

  Future<List<Map<String, dynamic>>> getMessagesByContact(int contactId) =>
      _getList('/messages/contact/$contactId');

  Future<List<Map<String, dynamic>>> _getList(String path) async {
    final response = await _httpClient.get(_uri(path));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final decoded = jsonDecode(response.body);
      if (decoded is List) {
        return decoded.map((e) => Map<String, dynamic>.from(e as Map)).toList();
      }
      return const [];
    }

    throw Exception('Request failed: ${response.statusCode} ${response.body}');
  }
}
