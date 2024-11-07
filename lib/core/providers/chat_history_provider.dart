import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat_history.dart';
import '../services/chat_history_service.dart';

class ChatHistoryProvider extends ChangeNotifier {
  final ChatHistoryService _chatHistoryService;
  List<ChatHistory> _chatHistories = [];
  ChatHistory? _currentChat;
  bool _isLoading = false;

  ChatHistoryProvider(FirebaseFirestore firestore, String userId)
      : _chatHistoryService = ChatHistoryService(firestore, userId) {
    _initializeListener();
  }

  List<ChatHistory> get chatHistories => _chatHistories;
  ChatHistory? get currentChat => _currentChat;
  bool get isLoading => _isLoading;

  void _initializeListener() {
    _chatHistoryService.getChatHistories().listen(
      (histories) {
        _chatHistories = histories;
        notifyListeners();
      },
      onError: (error) {
        debugPrint('Error loading chat histories: $error');
      },
    );
  }

  Future<void> createNewChat(String initialMessage) async {
    try {
      _isLoading = true;
      notifyListeners();

      final chatId = await _chatHistoryService.createChat(initialMessage);
      _chatHistoryService.getChatById(chatId).listen(
        (chat) {
          if (chat != null) {
            _currentChat = chat;
            notifyListeners();
          }
        },
        onError: (error) {
          debugPrint('Error loading current chat: $error');
        },
      );
    } catch (e) {
      debugPrint('Error creating new chat: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadChat(String chatId) async {
    try {
      _isLoading = true;
      notifyListeners();

      _chatHistoryService.getChatById(chatId).listen(
        (chat) {
          if (chat != null) {
            _currentChat = chat;
            notifyListeners();
          }
        },
        onError: (error) {
          debugPrint('Error loading chat: $error');
        },
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateChatTitle(String chatId, String newTitle) async {
    try {
      await _chatHistoryService.updateChatTitle(chatId, newTitle);
    } catch (e) {
      debugPrint('Error updating chat title: $e');
    }
  }

  Future<void> addMessage(ChatMessage message) async {
    if (_currentChat == null) return;

    try {
      await _chatHistoryService.addMessage(_currentChat!.id, message);
    } catch (e) {
      debugPrint('Error adding message: $e');
    }
  }

  Future<void> deleteChat(String chatId) async {
    try {
      await _chatHistoryService.deleteChat(chatId);
      if (_currentChat?.id == chatId) {
        _currentChat = null;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error deleting chat: $e');
    }
  }

  void clearCurrentChat() {
    _currentChat = null;
    notifyListeners();
  }
}
