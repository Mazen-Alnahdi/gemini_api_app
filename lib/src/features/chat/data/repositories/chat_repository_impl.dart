
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gemini_api_app/src/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:gemini_api_app/src/features/chat/domain/entities/chat_message.dart';
import 'package:gemini_api_app/src/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl(this.remoteDataSource);

  @override
  Future<ChatMessage> sendMessage(List<Content> messages) async {
    final response = await remoteDataSource.sendMessage(messages);
    return ChatMessage(text: response, isUser: false, timestamp: DateTime.now());
  }
}
