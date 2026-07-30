import 'package:chat_nuxt_flutter/src/core/app_scope.dart';
import 'package:chat_nuxt_flutter/src/core/app_state.dart';
import 'package:chat_nuxt_flutter/src/core/auth/auth_controller.dart';
import 'package:chat_nuxt_flutter/src/core/auth/session_store.dart';
import 'package:chat_nuxt_flutter/src/core/config/app_config.dart';
import 'package:chat_nuxt_flutter/src/core/network/api_client.dart';
import 'package:chat_nuxt_flutter/src/core/network/ws_client.dart';
import 'package:chat_nuxt_flutter/src/features/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _SuccessApiClient extends ApiClient {
  _SuccessApiClient() : super(AppConfig.defaultConfig);

  @override
  Future<String> login({required String username, required String password}) async {
    return 'token-$username';
  }
}

void main() {
  testWidgets('login form authenticates user', (tester) async {
    final auth = AuthController(
      apiClient: _SuccessApiClient(),
      sessionStore: SessionStore(),
    );
    final state = AppState(
      apiClient: _SuccessApiClient(),
      wsChatClient: WsChatClient(AppConfig.defaultConfig),
    );

    await tester.pumpWidget(
      AppScope(
        auth: auth,
        state: state,
        child: const MaterialApp(home: LoginPage()),
      ),
    );

    await tester.enterText(find.byType(TextFormField).at(0), 'demo');
    await tester.enterText(find.byType(TextFormField).at(1), 'password');
    await tester.tap(find.text('Ingresar'));
    await tester.pumpAndSettle();

    expect(auth.isAuthenticated, true);
  });
}
