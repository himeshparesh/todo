import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:todoapp/todoscreen/todo.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TodoApp',
      debugShowCheckedModeBanner: false,
      home: todo(),
    );
  }
}