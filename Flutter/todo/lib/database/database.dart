import 'package:hive/hive.dart';

class TodoDataBase {
  List TodoList = [];

  final _myBox = Hive.box('mybox');

  void createData() {
    TodoList = [
      ["TODO", false],
    ];
  }

  void loadData() {
    TodoList = _myBox.get("TODOLIST");
  }

  void updateDatabase() {
    _myBox.put("TODOLIST", TodoList);
  }
}
