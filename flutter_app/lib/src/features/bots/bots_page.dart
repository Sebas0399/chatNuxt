import 'package:flutter/material.dart';

import '../../core/app_scope.dart';

class BotsPage extends StatefulWidget {
  const BotsPage({super.key});

  @override
  State<BotsPage> createState() => _BotsPageState();
}

class _BotsPageState extends State<BotsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppScope.of(context).state.loadBotTypes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context).state;

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              const Text('Categorías de Bot', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ...state.botTypes.map((bot) {
                final name = bot['name']?.toString() ?? '-';
                final active = state.selectedBotType == name;
                return Card(
                  child: ListTile(
                    selected: active,
                    title: Text(name),
                    onTap: () => state.loadBotsByType(name),
                  ),
                );
              }),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Text(
                'Instancias de ${state.selectedBotType ?? ''}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              if (state.botsByType.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('No hay instancias configuradas'),
                  ),
                )
              else
                ...state.botsByType.map(
                  (bot) => Card(
                    child: ListTile(
                      title: Text(bot['name']?.toString() ?? '-'),
                      subtitle: Text('Trigger: ${bot['trigger'] ?? '-'}'),
                      leading: Text('#${bot['id'] ?? '-'}'),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
