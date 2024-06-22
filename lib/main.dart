import'package:flutter/material.dart';
import'home.dart';
import'package:hive_flutter/hive_flutter.dart';

void main()async{

  //initiate Hive
  await Hive.initFlutter();

  //create a box
  var box = await Hive.openBox("myBox");

  runApp(ToDo());
}

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
