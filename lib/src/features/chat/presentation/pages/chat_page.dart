
import 'package:flutter/material.dart';
import 'package:gemini_api_app/src/features/chat/presentation/manager/chat_provider.dart';
import 'package:gemini_api_app/src/features/chat/presentation/widgets/message_bubble.dart';
import 'package:gemini_api_app/src/features/chat/presentation/widgets/text_input_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatProvider>().addListener(_scrollToBottom);
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: Text('Gemini Chat', style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: const Color(0xFF4A90E2),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (context, provider, child) {
                if (provider.messages.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chat, size: 80, color: Colors.grey[400]),
                        const SizedBox(height: 20),
                        Text(
                          'Send a message to start the conversation',
                          style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16.0),
                  itemCount: provider.messages.length,
                  itemBuilder: (context, index) {
                    final message = provider.messages[index];
                    return MessageBubble(text: message.text, isUser: message.isUser);
                  },
                );
              },
            ),
          ),
          Consumer<ChatProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          TextInputField(
            controller: _controller,
            onSendMessage: _sendMessage,
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      context.read<ChatProvider>().sendMessage(_controller.text);
      _controller.clear();
      FocusScope.of(context).unfocus();
      _scrollToBottom();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    context.read<ChatProvider>().removeListener(_scrollToBottom);
    super.dispose();
  }
}
