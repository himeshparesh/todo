import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/detailscreen/detail.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class todo extends StatefulWidget {
  todo({Key key}) : super(key: key);

  @override
  _todoState createState() => _todoState();
}

class _todoState extends State<todo> {
  final firestoreInstance = FirebaseFirestore.instance;
  //  FirebaseFirestore.instance
  //       .collection("eventDetails")
  //       .where("chapterNumber", isEqualTo : "121 ")
  //       .get().then((value){
  //         value.docs.forEach((element) {
  //          FirebaseFirestore.instance.collection("eventDetails").doc(element.id).delete().then((value){
  //            print("Success!");
  //          });
  //         });
  //       });
  Future<QuerySnapshot> _myData =
      FirebaseFirestore.instance.collection('todo').get();

  onPressAddToTodo() {
    Get.to(() => Detail());
  }

  @override
  void initState() {
    super.initState();
  }

  onPressDelete() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Are you sure you want to delete all Todos?"),
          actions: [
            TextButton(
                onPressed: () {
                  firestoreInstance
                      .collection("todo")
                      .get()
                      .then((querySnapshot) {
                    querySnapshot.docs.forEach((result) {
                      result.reference.delete();
                    });
                  });
                  
                  setState(() {
                    _myData = firestoreInstance.collection('todo').get();
                    Get.back();
                  });
                },
                child: Text("Delete")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"))
          ],
          content: Text("All Record will be permanently deleted!"),
        );
      },
    );
  }

  onPressDeleteItem(id) {
    firestoreInstance.collection("todo").doc(id).delete().then((_) {
      setState(() {
        _myData = FirebaseFirestore.instance.collection('todo').get();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.blue,
        title: Text(
          "Todo List",
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        actions: [
          GestureDetector(
            onTap: () => onPressDelete(),
            child: SizedBox(
              width: 50,
              child: Icon(
                Icons.delete_outline,
                size: 25,
                color: Colors.red[50],
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<QuerySnapshot>(
              future: _myData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data.docs;
                  if (documents.length > 0) {
                    return ListView(
                        children: documents
                            .map(
                              (doc) => Dismissible(
                                onDismissed: (direction) {
                                  firestoreInstance
                                      .collection("todo")
                                      .doc(doc.id)
                                      .delete()
                                      .then((_) {
                                    print("success!");
                                  });
                                },
                                key: Key(UniqueKey().toString()),
                                child: Card(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  elevation: 5,
                                  child: ListTile(
                                    title: Text(doc["t_title"]),
                                    trailing: IconButton(
                                        icon: Icon(Icons.delete_outline_rounded),
                                        color: Colors.red[300],
                                        onPressed: () => onPressDeleteItem(doc.id)),
                                    onTap: () {
                                      Get.to(() => Detail(),
                                          arguments: doc); //[doc["t_title"],doc.id]
                                    },
                                  ),
                                ),
                              ),
                            )
                            .toList());
                  } else {
                    return Image.asset('assets/nodata.png');
                  }
                } else {
                  return SpinKitWanderingCubes(
                    color: Colors.blue,
                    size: 100.0,
                    duration: Duration(seconds: 05),
                  );
                }
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: onPressAddToTodo,
        backgroundColor: Colors.blue[200],
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
