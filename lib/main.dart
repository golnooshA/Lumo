import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lumo/screen/bookmark_page.dart';
import 'screen/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lumo Book App',
      home: BookmarkPage(), // your homepage
    );
  }
}
