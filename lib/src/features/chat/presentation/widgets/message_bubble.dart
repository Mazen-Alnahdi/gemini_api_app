
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown_widget/markdown_widget.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.text, required this.isUser});

  final String text;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    final radius = const Radius.circular(20.0);
    return Row(
      mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isUser)
          const CircleAvatar(
            backgroundColor: Color(0xFF4A90E2),
            child: Text('G', style: TextStyle(color: Colors.white)),
          ),
        const SizedBox(width: 8),
        Flexible(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: isUser ? const Color(0xFF4A90E2) : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: radius,
                topRight: radius,
                bottomLeft: isUser ? radius : Radius.zero,
                bottomRight: isUser ? Radius.zero : radius,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: isUser
                ? Text(
                    text,
                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
                  )
                : MarkdownWidget(
                    data: text,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    config: MarkdownConfig(
                      configs: [
                        PConfig(textStyle: GoogleFonts.poppins(fontSize: 16, color: Colors.black87)),
                      ],
                    ),
                  ),
          ),
        ),
        if (isUser)
          const SizedBox(width: 8),
        if (isUser)
          const CircleAvatar(
            backgroundColor: Colors.grey,
            child: Text('U', style: TextStyle(color: Colors.white)),
          ),
      ],
    );
  }
}
