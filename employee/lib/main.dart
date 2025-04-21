import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:employee/main.dart';

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
      title: 'Employee App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const employee_form(),
    );
  }
}
