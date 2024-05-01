import 'package:firebase_core/firebase_core.dart';
import 'package:godzilla/common/color_extension.dart';
import 'package:godzilla/view/main_tab/main_tab_view.dart';
import 'firebase_options.dart';
import 'package:godzilla/loginandsign/sign_up_page.dart';
//import 'package:godzilla/body/start.dart';
import 'package:godzilla/loginandsign/login.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeDateFormatting().then((_) => runApp(MyApp()));
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
      home: const Login(),
    );
  }
}