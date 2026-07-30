import 'dart:convert';
import 'dart:io';

import '../config/app_config.dart';

class ApiClient {
  ApiClient(this._config);

  final AppConfig _config;
  final HttpClient _httpClient = HttpClient();

  Uri _uri(String path) {
    final base = Uri.parse(_config.apiBase);
    return base.replace(path: '${base.path}$path');
  }

  Future<String> login({required String username, required String password}) async {
    final request = await _httpClient.postUrl(_uri('/companies/login'));
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode({'username': username, 'password': password}));

    final response = await request.close();
    final body = await response.transform(utf8.decoder).join();
    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        return jsonDecode(body) as String;
      } catch (_) {
        return body;
      }
    }

    throw HttpException('Login failed: ${response.statusCode} $body');
  }

  Future<List<Map<String, dynamic>>> getBotTypes() => _getList('/botTypes');

  Future<List<Map<String, dynamic>>> getBotsByType(String type) =>
      _getList('/bots/$type');

  Future<List<Map<String, dynamic>>> getContactsByCompany(int companyId) =>
      _getList('/contacts/company/$companyId');

  Future<List<Map<String, dynamic>>> getMessagesByContact(int contactId) =>
      _getList('/messages/contact/$contactId');

  Future<List<Map<String, dynamic>>> _getList(String path) async {
    final request = await _httpClient.getUrl(_uri(path));
    final response = await request.close();
    final body = await response.transform(utf8.decoder).join();

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final decoded = jsonDecode(body);
      if (decoded is List) {
        return decoded.map((e) => Map<String, dynamic>.from(e as Map)).toList();
      }
      return const [];
    }

    throw HttpException('Request failed: ${response.statusCode} $body');
  }
}
