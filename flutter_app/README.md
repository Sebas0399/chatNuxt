# chatNuxt Flutter Migration

This directory contains the Flutter migration target for `chatNuxt`.

## Scope

- Mobile-first Flutter target (Android/iOS)
- Core parity for: login, bots, chat, flows, company, dashboard
- API base defaults to `http://localhost:8080`
- WebSocket base defaults to `ws://localhost:8080`

## Run

```bash
cd /home/runner/work/chatNuxt/chatNuxt/flutter_app
flutter pub get
flutter run
```

## Tests

```bash
cd /home/runner/work/chatNuxt/chatNuxt/flutter_app
flutter test
```

## Environment overrides

Use Dart defines:

```bash
flutter run --dart-define=API_BASE_URL=http://localhost:8080 --dart-define=WS_BASE_URL=ws://localhost:8080
```
