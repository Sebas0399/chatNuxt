import 'dart:convert';
import 'dart:io';

class SessionStore {
  SessionStore([String? filePath])
      : _file = File(filePath ?? '${Directory.current.path}/.chatnuxt_session.json');

  final File _file;

  Future<Map<String, dynamic>?> load() async {
    if (!await _file.exists()) return null;
    final raw = await _file.readAsString();
    if (raw.trim().isEmpty) return null;
    final decoded = jsonDecode(raw);
    if (decoded is Map) {
      return Map<String, dynamic>.from(decoded);
    }
    return null;
  }

  Future<void> save({required String token, required String username}) async {
    final payload = jsonEncode({'token': token, 'username': username});
    await _file.writeAsString(payload, flush: true);
  }

  Future<void> clear() async {
    if (await _file.exists()) {
      await _file.delete();
    }
  }
}
