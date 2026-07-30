import 'dart:io';

import 'package:chat_nuxt_flutter/src/core/auth/auth_controller.dart';
import 'package:chat_nuxt_flutter/src/core/auth/session_store.dart';
import 'package:chat_nuxt_flutter/src/core/config/app_config.dart';
import 'package:chat_nuxt_flutter/src/core/network/api_client.dart';
import 'package:flutter_test/flutter_test.dart';

class _SuccessApiClient extends ApiClient {
  _SuccessApiClient() : super(AppConfig.defaultConfig);

  @override
  Future<String> login({required String username, required String password}) async {
    return 'token-$username';
  }
}

class _FailApiClient extends ApiClient {
  _FailApiClient() : super(AppConfig.defaultConfig);

  @override
  Future<String> login({required String username, required String password}) {
    throw const HttpException('bad credentials');
  }
}

void main() {
  test('login success persists session', () async {
    final tmpDir = await Directory.systemTemp.createTemp('chatnuxt-auth-test');
    final store = SessionStore('${tmpDir.path}/session.json');
    final auth = AuthController(apiClient: _SuccessApiClient(), sessionStore: store);

    final ok = await auth.login('demo', 'password');

    expect(ok, true);
    expect(auth.isAuthenticated, true);
    expect(auth.username, 'demo');

    final reload = AuthController(apiClient: _SuccessApiClient(), sessionStore: store);
    await reload.loadSession();
    expect(reload.isAuthenticated, true);
    expect(reload.username, 'demo');
  });

  test('login failure exposes error', () async {
    final tmpDir = await Directory.systemTemp.createTemp('chatnuxt-auth-test');
    final auth = AuthController(
      apiClient: _FailApiClient(),
      sessionStore: SessionStore('${tmpDir.path}/session.json'),
    );

    final ok = await auth.login('demo', 'bad');

    expect(ok, false);
    expect(auth.isAuthenticated, false);
    expect(auth.error, isNotNull);
  });
}
