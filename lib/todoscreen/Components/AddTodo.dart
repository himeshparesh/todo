import 'dart:async';

import 'package:flutter/material.dart';

class AddTodo extends StatelessWidget {
  final Function onPressAddToTodo;
  // final ValueChanged<String> onChangeText;
  final TextEditingController myController;

  const AddTodo({
    this.onPressAddToTodo,
    // this.onChangeText,
    this.myController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: myController,
            // onChanged: onChangeText,
            decoration: InputDecoration(
              hintText: "Write something here!",
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: ElevatedButton(
            onPressed: onPressAddToTodo,
            style: ElevatedButton.styleFrom(
              primary: Colors.blueGrey,
              elevation: 2,
            ),
            child: Container(
                margin: EdgeInsets.all(6),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text("Add", style: TextStyle(fontSize: 15))),
          ),
        )
      ],
    );
  }
}
