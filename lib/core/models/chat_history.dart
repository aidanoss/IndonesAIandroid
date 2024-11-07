class ChatHistory {
  final String id;
  final String title;
  final DateTime timestamp;
  final String lastMessage;
  final List<ChatMessage> messages;

  ChatHistory({
    required this.id,
    required this.title,
    required this.timestamp,
    required this.lastMessage,
    required this.messages,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'timestamp': timestamp,
      'lastMessage': lastMessage,
      'messages': messages.map((message) => message.toMap()).toList(),
    };
  }

  factory ChatHistory.fromMap(Map<String, dynamic> map) {
    return ChatHistory(
      id: map['id'] as String,
      title: map['title'] as String,
      timestamp: (map['timestamp'] as dynamic).toDate(),
      lastMessage: map['lastMessage'] as String,
      messages: List<ChatMessage>.from(
        (map['messages'] as List).map(
          (messageMap) =>
              ChatMessage.fromMap(messageMap as Map<String, dynamic>),
        ),
      ),
    );
  }

  ChatHistory copyWith({
    String? id,
    String? title,
    DateTime? timestamp,
    String? lastMessage,
    List<ChatMessage>? messages,
  }) {
    return ChatHistory(
      id: id ?? this.id,
      title: title ?? this.title,
      timestamp: timestamp ?? this.timestamp,
      lastMessage: lastMessage ?? this.lastMessage,
      messages: messages ?? this.messages,
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'isUser': isUser,
      'timestamp': timestamp,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      text: map['text'] as String,
      isUser: map['isUser'] as bool,
      timestamp: (map['timestamp'] as dynamic).toDate(),
    );
  }
}
