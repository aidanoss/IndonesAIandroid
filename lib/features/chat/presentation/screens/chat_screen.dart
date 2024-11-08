import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/providers/chat_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../features/settings/presentation/screens/settings_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openChatHistory() {
    _scaffoldKey.currentState?.openDrawer();
  }

  Widget _buildMessageBubble({
    required String message, 
    required bool isUser,
    required DateTime timestamp,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final subtextColor = isDarkMode ? Colors.grey[400] : Colors.grey[600];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: 
          isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) 
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: _buildAvatar(
                'images/avatars/ai_avatar.png', 
                isDarkMode ? Colors.grey[700] : Colors.grey[300],
                false
              ),
            ),
          
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              decoration: BoxDecoration(
                gradient: isUser 
                  ? LinearGradient(
                      colors: [
                        AppTheme.primaryRed,
                        AppTheme.primaryRed.withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : LinearGradient(
                      colors: [
                        isDarkMode ? Colors.grey[800] ?? Colors.grey : Colors.white, 
                        isDarkMode ? Colors.grey[750] ?? Colors.grey : Colors.grey[100] ?? Colors.white
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: isUser ? const Radius.circular(16) : Radius.zero,
                  bottomRight: isUser ? Radius.zero : const Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: !isUser && !isDarkMode 
                  ? Border.all(color: Colors.grey[200] ?? Colors.grey, width: 1) 
                  : null,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: isUser 
                  ? CrossAxisAlignment.end 
                  : CrossAxisAlignment.start,
                children: [
                  Text(
                    message.isEmpty ? 'No message' : message,
                    style: TextStyle(
                      color: isUser ? Colors.white : textColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      color: isUser 
                        ? Colors.white.withOpacity(0.7) 
                        : subtextColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          if (isUser) 
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: _buildAvatar(
                'images/avatars/user_avatar.png', 
                isDarkMode ? Colors.grey[700] : Colors.grey[300],
                true
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String imagePath, Color? fallbackColor, bool isUser) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.transparent,
      child: ClipOval(
        child: Image.asset(
          imagePath,
          width: 40,
          height: 40,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 40,
              height: 40,
              color: fallbackColor ?? Colors.grey[300],
              child: Icon(
                isUser ? Icons.person : Icons.smart_toy_outlined,
                color: Colors.white,
                size: 24,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final subtextColor = isDarkMode ? Colors.grey[400] : Colors.grey[600];

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.history, color: isDarkMode ? Colors.white : Colors.black87),
          onPressed: _openChatHistory,
        ),
        title: const Text(
          'IndonesAI', 
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: isDarkMode ? Colors.white : Colors.black87),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: isDarkMode ? Colors.grey[850] : Colors.white,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[800] : AppTheme.primaryRed.withOpacity(0.1),
                ),
                child: Text(
                  'Riwayat Percakapan',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Placeholder for future chat history items
              Center(
                child: Text(
                  'Belum ada riwayat percakapan',
                  style: TextStyle(
                    color: subtextColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (context, chatProvider, _) {
                final messages = chatProvider.messages;

                if (messages.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 64,
                          color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Mulai percakapan dengan mengirim pesan.',
                          style: TextStyle(
                            color: subtextColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    
                    // Null safety checks
                    final isUser = message['isUser'] as bool? ?? false;
                    final text = message['text'] as String? ?? '';
                    final timestamp = message['timestamp'] as DateTime? ?? DateTime.now();

                    return _buildMessageBubble(
                      message: text, 
                      isUser: isUser,
                      timestamp: timestamp,
                    );
                  },
                );
              },
            ),
          ),
          const _ChatInputArea(),
        ],
      ),
    );
  }
}

class _ChatInputArea extends StatefulWidget {
  const _ChatInputArea({Key? key}) : super(key: key);

  @override
  _ChatInputAreaState createState() => _ChatInputAreaState();
}

class _ChatInputAreaState extends State<_ChatInputArea> {
  final _controller = TextEditingController();
  bool _isTyping = false;

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      context.read<ChatProvider>().sendMessage(text);
      _controller.clear();
      setState(() {
        _isTyping = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final subtextColor = isDarkMode ? Colors.grey[400] : Colors.grey[600];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[850] : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!, 
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.camera_alt_outlined, color: subtextColor),
            onPressed: () {
              // TODO: Implement camera/image upload
              print('Camera/image upload functionality to be implemented');
            },
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  _isTyping = value.isNotEmpty;
                });
              },
              decoration: InputDecoration(
                hintText: 'Tulis pesan...',
                filled: true,
                fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16, 
                  vertical: 12
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: AppTheme.primaryRed, 
                    width: 1.5
                  ),
                ),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.mic_none, color: subtextColor),
            onPressed: () {
              // TODO: Implement voice input
              print('Voice input functionality to be implemented');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.send, 
              color: _isTyping 
                ? AppTheme.primaryRed 
                : subtextColor,
            ),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
