import 'package:flutter/material.dart';

class FlowsPage extends StatelessWidget {
  const FlowsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nodes = const [
      {'id': '1', 'label': 'Node 1'},
      {'id': '2', 'label': 'Node 2'},
      {'id': '3', 'label': 'Node 3'},
      {'id': '4', 'label': 'Special Node'},
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (_, i) {
        final node = nodes[i];
        return ListTile(
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          leading: CircleAvatar(child: Text(node['id']!)),
          title: Text(node['label']!),
          subtitle: const Text('Visual flow placeholder for Flutter migration'),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemCount: nodes.length,
    );
  }
}
