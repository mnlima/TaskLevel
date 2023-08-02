import 'package:flutter/material.dart';
import 'package:task_level/data/task_inherited.dart';
import 'package:task_level/screens/form_screen.dart';
import 'package:task_level/screens/initial_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Level',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskInherited(
        child: const InitialScreen(),
      ),
    );
  }
}
