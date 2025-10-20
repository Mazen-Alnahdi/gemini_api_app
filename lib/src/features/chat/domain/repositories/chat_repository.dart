
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gemini_api_app/src/features/chat/domain/entities/chat_message.dart';

abstract class ChatRepository {
  Future<ChatMessage> sendMessage(List<Content> messages);
}
