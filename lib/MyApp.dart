import 'package:flutter/material.dart';
import 'package:todoapp/todoscreen/todo.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoApp',
      debugShowCheckedModeBanner: false,
      home: todo(),
    );
  }
}