class AppConfig {
  const AppConfig({
    required this.apiBase,
    required this.websocketBase,
  });

  final String apiBase;
  final String websocketBase;

  static const AppConfig defaultConfig = AppConfig(
    apiBase: String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'http://localhost:8080',
    ),
    websocketBase: String.fromEnvironment(
      'WS_BASE_URL',
      defaultValue: 'ws://localhost:8080',
    ),
  );
}
