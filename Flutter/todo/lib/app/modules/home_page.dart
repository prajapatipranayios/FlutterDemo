import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/app/modules/dialog_box.dart';
import 'package:todo/app/modules/todo_item.dart';
import 'package:todo/database/database.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();

  final _myBox = Hive.box("mybox");
  TodoDataBase db = TodoDataBase();

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  // List TodoList = [
  //   ["TODO", false],
  //   ["TODO", false],
  //   ["TODO", false],
  //   ["TODO", false],
  //   ["TODO", false],
  //   ["TODO", false],
  //   ["TODO", false],
  // ];

  void deleteTask(int index) {
    setState(() {
      db.TodoList.removeAt(index);
    });
    db.updateDatabase();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.TodoList[index][1] = !db.TodoList[index][1];
    });
    db.updateDatabase();
  }

  void onChanged(bool? value) {
    setState(() {});
  }

  void saveNewTask() {
    setState(() {
      db.TodoList.add([_controller.text, false]);
      _controller.clear();
      Navigator.of(context).pop();
    });
    db.updateDatabase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
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
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: db.TodoList.length,
        itemBuilder: (context, index) {
          return TodoItem(
            isChecked: db.TodoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            todoText: db.TodoList[index][0],
            onPressed: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
