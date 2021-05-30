import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/components/RoundedButton.dart';
import 'package:todoapp/components/TextFieldContainer.dart';
import 'package:todoapp/todoscreen/todo.dart';

class Detail extends StatefulWidget {
  Detail({Key key}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final myController = TextEditingController();
  String title = "";

  @override
  void initState() {
    var doc = Get.arguments;
    if (doc != null) {
      myController.text = doc["t_title"];
    }

    super.initState();
  }

  onPressSaveChanges() {
    var doc = Get.arguments;
    final firestoreInstance = FirebaseFirestore.instance;
    if (doc == null) {
      firestoreInstance.collection("todo").add({
        "t_title": myController.text,
      }).then((value) {
        print(value.id);
      });
    } else {
      firestoreInstance.collection("todo").doc(doc.id).set({
        "t_title": myController.text,
      }).then((_) {
        print("success!");
      });
    }

    FocusScope.of(context).unfocus();
    Get.offAll(() => todo());
    // Get.to(() => todo());
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.blue,
        title: Text(
          "Add todo",
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFieldContainer(
                child: TextField(
                  controller: myController,
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                      hintText: "Enter something to add to your todo list",
                      border: InputBorder.none),
                ),
              ),
              RoundedButton(
                text: "Save changes",
                onButtonPress: onPressSaveChanges,
                color: Colors.purple[500],
                txtColor: Colors.white,
                border: 10,
                btnWidth: size.width * 0.9,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
