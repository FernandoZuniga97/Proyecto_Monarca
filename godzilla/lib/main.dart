import 'package:firebase_core/firebase_core.dart';
import 'package:godzilla/common/color_extension.dart';
import 'package:godzilla/view/main_tab/main_tab_view.dart';
import 'firebase_options.dart';
//import 'package:godzilla/body/start.dart';
//import 'package:godzilla/login.dart';
import 'package:flutter/material.dart';
import 'package:godzilla/view/login/welcome_view.dart';

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
      theme: ThemeData(
        fontFamily: "Inter",
        colorScheme: ColorScheme.fromSeed(
          seedColor: TColor.primary,
          background: TColor.gray80,
          primary: TColor.primary,
          primaryContainer: TColor.gray60,
          secondary: TColor.secondary,
        ),
        useMaterial3: false,
      ),
      home: const MainTabView(),
      //routes: {
        //'/': (context) => const Login(),
        //'/start': (context) => const HomeView(),
      //},
    );
  }
}