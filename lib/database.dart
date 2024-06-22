import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase{
  //reference hive box
  final _myBox = Hive.box("MyBox");

  List todoList = [];

  void createDefaultlist(){
    todoList = [
      ["Make App", false],
      ["Do Exercise", false],
    ];
  }

  //load data
  void loadData(){
    todoList = _myBox.get("TODOLIST");
  }

  //update data
  void updateData(){
    _myBox.put("TODOLIST", todoList);
  }

}


