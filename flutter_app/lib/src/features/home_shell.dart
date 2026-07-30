import 'package:flutter/material.dart';

import '../core/app_scope.dart';
import 'bots/bots_page.dart';
import 'chat/chat_page.dart';
import 'company/company_page.dart';
import 'dashboard/dashboard_page.dart';
import 'flows/flows_page.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _tabIndex = 0;

  static const _titles = [
    'Dashboard',
    'Bots',
    'Chat',
    'Flows',
    'Company',
  ];

  final _pages = const [
    DashboardPage(),
    BotsPage(),
    ChatPage(),
    FlowsPage(),
    CompanyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final auth = AppScope.of(context).auth;
    final state = AppScope.of(context).state;

    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_tabIndex]),
        actions: [
          if (auth.username != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Center(child: Text(auth.username!)),
            ),
          IconButton(
            onPressed: () => auth.logout(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          if (state.error != null)
            MaterialBanner(
              content: Text(state.error!),
              actions: [
                TextButton(
                  onPressed: () => setState(() => state.error = null),
                  child: const Text('Dismiss'),
                )
              ],
            ),
          Expanded(child: _pages[_tabIndex]),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabIndex,
        onDestinationSelected: (value) => setState(() => _tabIndex = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.smart_toy), label: 'Bots'),
          NavigationDestination(icon: Icon(Icons.chat), label: 'Chat'),
          NavigationDestination(icon: Icon(Icons.account_tree), label: 'Flows'),
          NavigationDestination(icon: Icon(Icons.business), label: 'Company'),
        ],
      ),
    );
  }
}
