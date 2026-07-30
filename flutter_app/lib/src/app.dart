import 'package:flutter/material.dart';

import 'core/app_scope.dart';
import 'core/app_state.dart';
import 'core/auth/auth_controller.dart';
import 'core/auth/session_store.dart';
import 'core/config/app_config.dart';
import 'core/network/api_client.dart';
import 'core/network/ws_client.dart';
import 'features/home_shell.dart';
import 'features/login/login_page.dart';

class ChatNuxtApp extends StatefulWidget {
  const ChatNuxtApp({super.key});

  @override
  State<ChatNuxtApp> createState() => _ChatNuxtAppState();
}

class _ChatNuxtAppState extends State<ChatNuxtApp> {
  late final AppConfig _config;
  late final ApiClient _apiClient;
  late final WsChatClient _wsChatClient;
  late final AuthController _auth;
  late final AppState _state;
  bool _sessionLoaded = false;

  @override
  void initState() {
    super.initState();
    _config = AppConfig.defaultConfig;
    _apiClient = ApiClient(_config);
    _wsChatClient = WsChatClient(_config);
    _auth = AuthController(
      apiClient: _apiClient,
      sessionStore: SessionStore(),
    )..loadSession().then((_) {
        if (mounted) {
          setState(() => _sessionLoaded = true);
        }
      });

    _state = AppState(apiClient: _apiClient, wsChatClient: _wsChatClient);
  }

  @override
  void dispose() {
    _auth.dispose();
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_auth, _state]),
      builder: (context, _) {
        return AppScope(
          auth: _auth,
          state: _state,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'chatNuxt Flutter',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D9488)),
              scaffoldBackgroundColor: const Color(0xFFFAFAFA),
              useMaterial3: true,
            ),
            home: !_sessionLoaded
                ? const Scaffold(body: Center(child: CircularProgressIndicator()))
                : _auth.isAuthenticated
                    ? const HomeShell()
                    : const LoginPage(),
          ),
        );
      },
    );
  }
}
