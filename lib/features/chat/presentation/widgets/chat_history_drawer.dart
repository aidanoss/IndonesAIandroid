import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../../core/providers/chat_history_provider.dart';
import '../../../../core/models/chat_history.dart';
import '../../../../core/theme/app_theme.dart';

class ChatHistoryDrawer extends StatelessWidget {
  const ChatHistoryDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<ChatHistoryProvider>(
        builder: (context, chatHistoryProvider, _) {
          return Column(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: AppTheme.indonesianRed,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Chat History',
                      style: TextStyle(
                        color: AppTheme.indonesianWhite,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        chatHistoryProvider.clearCurrentChat();
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('New Chat'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.indonesianWhite,
                        foregroundColor: AppTheme.indonesianRed,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: chatHistoryProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : chatHistoryProvider.chatHistories.isEmpty
                        ? const Center(
                            child: Text('No chat history yet'),
                          )
                        : ListView.builder(
                            itemCount: chatHistoryProvider.chatHistories.length,
                            itemBuilder: (context, index) {
                              final chat =
                                  chatHistoryProvider.chatHistories[index];
                              return _ChatHistoryTile(chat: chat);
                            },
                          ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ChatHistoryTile extends StatelessWidget {
  final ChatHistory chat;

  const _ChatHistoryTile({required this.chat});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('MMM d, y').format(chat.timestamp);

    return Dismissible(
      key: Key(chat.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Chat'),
            content: const Text('Are you sure you want to delete this chat?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<ChatHistoryProvider>(context, listen: false)
            .deleteChat(chat.id);
      },
      child: ListTile(
        leading: const Icon(
          Icons.chat_bubble_outline,
          color: AppTheme.indonesianRed,
        ),
        title: Text(
          chat.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '${chat.lastMessage}\n$formattedDate',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => _showEditTitleDialog(context, chat),
        ),
        onTap: () {
          Provider.of<ChatHistoryProvider>(context, listen: false)
              .loadChat(chat.id);
          Navigator.pop(context);
        },
      ),
    );
  }

  Future<void> _showEditTitleDialog(
      BuildContext context, ChatHistory chat) async {
    final controller = TextEditingController(text: chat.title);
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Chat Title'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Title',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                Provider.of<ChatHistoryProvider>(context, listen: false)
                    .updateChatTitle(chat.id, controller.text.trim());
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
