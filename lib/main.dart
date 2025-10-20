
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gemini_api_app/src/features/chat/presentation/manager/chat_provider.dart';
import 'package:gemini_api_app/src/features/chat/presentation/pages/chat_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Gemini.init(apiKey: dotenv.env['GEMINI_API_KEY']!);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      child: MaterialApp(
        title: 'Gemini API App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ChatPage(),
      ),
    );
  }
}
