import 'package:flutter/material.dart';
import 'package:todoapp/todoscreen/Components/AddTodo.dart';

class todo extends StatefulWidget {
  todo({Key key}) : super(key: key);

  @override
  _todoState createState() => _todoState();
}

class _todoState extends State<todo> {
  final myController = TextEditingController();
  List<String> intArr = [];

  onPressAddToTodo() {
    print("object" + myController.text);
    intArr.add(myController.text);
    setState(() {
      intArr = intArr;
      myController.text = '';
    });
    FocusScope.of(context).unfocus();
  }

  onPressDelete(isDeleteAll,snapshot, index) {
    isDeleteAll ? 
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Are you sure you want to delete all Todos?"),
          actions: [
            TextButton(
                onPressed: () {
                  intArr.clear();
                  setState(() {
                    intArr = intArr;
                  });
                  Navigator.of(context).pop();
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
    )
    :showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Are you sure you want to delete this Todo ?"),
          actions: [
            TextButton(
                onPressed: () {
                  intArr.remove(snapshot.data[index]);
                  setState(() {
                    intArr = intArr;
                  });
                  Navigator.of(context).pop();
                },
                child: Text("Delete")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"))
          ],
          content: Text("Record will be permanently deleted!"),
        );
      },
    );

    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.black12,
        title: Text(
          "Todo List",
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        actions: [
          InkWell(
              onTap: () => onPressDelete(true,'',''),
              child: intArr.length > 0
                  ? SizedBox(
                      width: 50,
                      child: Icon(
                        Icons.delete_outline,
                        size: 30,
                        color: Colors.red,
                      ),
                    )
                  : SizedBox())
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: intArr.length > 0
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: FutureBuilder(
                      initialData: intArr,
                      // future: intArr,
                      builder: (context, snapshot) {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      snapshot.data[index],
                                      style: TextStyle(
                                        fontSize: 30,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textWidthBasis: TextWidthBasis.parent,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => onPressDelete(false,snapshot, index),
                                    child: Icon(
                                      Icons.delete_outline,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                    )),
                    AddTodo(
                      myController: myController,
                      onPressAddToTodo: onPressAddToTodo,
                    ),
                  ],
                )
              : Container(
                  height: size.height * .9,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/nodata.png',
                        height: size.height * .35,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      AddTodo(
                        myController: myController,
                        onPressAddToTodo: onPressAddToTodo,
                      ),
                    ],
                  )),
        ),
      ),
    );
  }
}
