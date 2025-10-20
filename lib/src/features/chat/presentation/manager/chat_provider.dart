
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gemini_api_app/src/features/chat/domain/entities/chat_message.dart';

class ChatProvider extends ChangeNotifier {
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  final Gemini _gemini = Gemini.instance;

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;

  Future<void> sendMessage(String text) async {
    _messages.add(ChatMessage(text: text, isUser: true, timestamp: DateTime.now()));
    _isLoading = true;
    notifyListeners();

    try {
      String prompt = "";
      for (var msg in _messages) {
        prompt += "${msg.isUser ? 'User' : 'Bot'}: ${msg.text}\n";
      }

      final response = await _gemini.prompt(parts: [Part.text(prompt)]);

      if (response?.output != null) {
        final modelMessage = ChatMessage(
          text: response!.output!,
          isUser: false,
          timestamp: DateTime.now(),
        );
        _messages.add(modelMessage);
      }
    } catch (e) {
      _messages.add(ChatMessage(text: 'Error: ${e.toString()}', isUser: false, timestamp: DateTime.now()));
    }

    _isLoading = false;
    notifyListeners();
  }
}
