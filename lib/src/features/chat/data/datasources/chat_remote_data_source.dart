
import 'package:flutter_gemini/flutter_gemini.dart';

abstract class ChatRemoteDataSource {
  Future<String> sendMessage(List<Content> messages);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final Gemini gemini;

  ChatRemoteDataSourceImpl(this.gemini);

  @override
  Future<String> sendMessage(List<Content> messages) async {
    final response = await gemini.chat(messages);
    return response?.output ?? 'Error: Could not get a response.';
  }
}
