import 'package:flutter/material.dart';

import '../../core/app_scope.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppScope.of(context).state.loadContacts();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
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
              const Text('Chats Activos', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ...state.contacts.map((contact) {
                final active = state.selectedContact?['id'] == contact['id'];
                return Card(
                  child: ListTile(
                    selected: active,
                    title: Text(contact['name']?.toString() ?? 'Unknown'),
                    subtitle: Text(contact['phone']?.toString() ?? ''),
                    onTap: () => state.selectContact(contact),
                  ),
                );
              }),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              Expanded(
                child: state.selectedContact == null
                    ? const Center(child: Text('Seleccione un contacto'))
                    : ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: state.messages.length,
                        itemBuilder: (_, i) {
                          final message = state.messages[i];
                          final isCompany = message['from'] == 'COMPANY';
                          return Align(
                            alignment: isCompany
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.all(10),
                              constraints: const BoxConstraints(maxWidth: 320),
                              decoration: BoxDecoration(
                                color: isCompany
                                    ? const Color(0xFF0D9488)
                                    : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                message['text']?.toString() ?? '',
                                style: TextStyle(
                                  color: isCompany ? Colors.white : Colors.black87,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: 'Escriba su respuesta...',
                        ),
                        onSubmitted: (_) => _send(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: _send,
                      child: const Text('Enviar'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _send() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    AppScope.of(context).state.sendMessage(text);
    _messageController.clear();
  }
}
