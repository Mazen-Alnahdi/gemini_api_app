
import 'package:gemini_api_app/src/features/chat/domain/entities/chat_message.dart';

class ChatMessageModel extends ChatMessage {
  const ChatMessageModel({
    required super.text,
    required super.isUser,
    required super.timestamp,
  });

  factory ChatMessageModel.fromGemini(String text) {
    return ChatMessageModel(
      text: text,
      isUser: false,
      timestamp: DateTime.now(),
    );
  }
}
