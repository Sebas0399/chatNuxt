import 'package:flutter/widgets.dart';

import 'app_state.dart';
import 'auth/auth_controller.dart';

class AppScope extends InheritedWidget {
  const AppScope({
    super.key,
    required this.auth,
    required this.state,
    required super.child,
  });

  final AuthController auth;
  final AppState state;

  static AppScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope is missing in widget tree');
    return scope!;
  }

  @override
  bool updateShouldNotify(covariant AppScope oldWidget) {
    return oldWidget.auth != auth || oldWidget.state != state;
  }
}
