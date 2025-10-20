
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gemini_api_app/src/features/chat/domain/entities/chat_message.dart';
import 'package:gemini_api_app/src/features/chat/domain/repositories/chat_repository.dart';

class SendChatMessage {
  final ChatRepository repository;

  SendChatMessage(this.repository);

  Future<ChatMessage> call(List<Content> messages) {
    return repository.sendMessage(messages);
  }
}
