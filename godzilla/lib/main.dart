import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:godzilla/body//start.dart';
import 'package:godzilla/login.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      routes: {
        '/': (context) => const Login(),
        '/start': (context) => const Start(),
      },
    );
  }
}