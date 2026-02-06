import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/app/modules/dialog_box.dart';
import 'package:todo/app/modules/todo_item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _controller = TextEditingController();

  List TodoList = [
    ["TODO", false],
    ["TODO", false],
    ["TODO", false],
    ["TODO", false],
    ["TODO", false],
    ["TODO", false],
    ["TODO", false],
  ];

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      TodoList[index][1] = !TodoList[index][1];
    });
  }

  void onChanged(bool? value) {
    setState(() {

    });
  }

  void saveNewTask(){
    setState(() {
      TodoList.add([_controller.text, false]);
      _controller.clear();
      Navigator.of(context).pop();
    });
  }

  void createNewTask() {
    
    showDialog(context: context, builder: (context) {
      return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        title: Text('TODO'),
        backgroundColor: Colors.deepPurple[400],
        elevation: 10,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.deepPurple[400],
        child: Icon(Icons.add, color: Colors.white,),
      ),
      body: ListView.builder(
        itemCount: TodoList.length,
        itemBuilder: (context, index) {
          return TodoItem(
            isChecked: TodoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            todoText: TodoList[index][0],
          );
        },
      ),
    );
  }
}
