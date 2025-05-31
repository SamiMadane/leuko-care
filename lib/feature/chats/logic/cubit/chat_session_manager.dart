class ChatSessionManager {
  static final ChatSessionManager _instance = ChatSessionManager._internal();
  factory ChatSessionManager() => _instance;
  ChatSessionManager._internal();

  String? currentChatId;

  bool get isChatScreenActive => currentChatId != null;
}
