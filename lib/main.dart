import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_first_flutter_app/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Assure une initialisation correcte
  await Firebase.initializeApp(); // Initialise Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
