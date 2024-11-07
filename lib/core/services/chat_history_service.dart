import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat_history.dart';

class ChatHistoryService {
  final FirebaseFirestore _firestore;
  final String userId;

  ChatHistoryService(this._firestore, this.userId);

  // Collection reference
  CollectionReference<Map<String, dynamic>> get _chatsCollection =>
      _firestore.collection('users').doc(userId).collection('chats');

  // Create a new chat history
  Future<String> createChat(String initialMessage) async {
    final chatDoc = _chatsCollection.doc();
    final timestamp = DateTime.now();

    final chatHistory = ChatHistory(
      id: chatDoc.id,
      title: _generateTitle(initialMessage),
      timestamp: timestamp,
      lastMessage: initialMessage,
      messages: [
        ChatMessage(
          text: initialMessage,
          isUser: true,
          timestamp: timestamp,
        ),
      ],
    );

    await chatDoc.set(chatHistory.toMap());
    return chatDoc.id;
  }

  // Get all chat histories
  Stream<List<ChatHistory>> getChatHistories() {
    return _chatsCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ChatHistory.fromMap(doc.data()))
          .toList();
    });
  }

  // Get a specific chat history
  Stream<ChatHistory?> getChatById(String chatId) {
    return _chatsCollection.doc(chatId).snapshots().map((doc) {
      if (doc.exists) {
        return ChatHistory.fromMap(doc.data()!);
      }
      return null;
    });
  }

  // Update chat title
  Future<void> updateChatTitle(String chatId, String newTitle) async {
    await _chatsCollection.doc(chatId).update({'title': newTitle});
  }

  // Add message to chat
  Future<void> addMessage(String chatId, ChatMessage message) async {
    final chatDoc = _chatsCollection.doc(chatId);

    await _firestore.runTransaction((transaction) async {
      final chatSnapshot = await transaction.get(chatDoc);
      if (!chatSnapshot.exists) {
        throw Exception('Chat not found');
      }

      final currentChat = ChatHistory.fromMap(chatSnapshot.data()!);
      final updatedMessages = [...currentChat.messages, message];

      transaction.update(chatDoc, {
        'messages': updatedMessages.map((m) => m.toMap()).toList(),
        'lastMessage': message.text,
        'timestamp': message.timestamp,
      });
    });
  }

  // Delete chat
  Future<void> deleteChat(String chatId) async {
    await _chatsCollection.doc(chatId).delete();
  }

  // Generate title from first message
  String _generateTitle(String message) {
    const maxLength = 30;
    if (message.length <= maxLength) {
      return message;
    }
    return '${message.substring(0, maxLength)}...';
  }
}
