import 'package:flutter/material.dart';
import 'package:todo_app/database.dart';
import 'package:todo_app/todotile.dart';
import 'dialogbox.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //for loading the list of tasks
  @override
  void initState() {
    if(_myBox.get("TODOLIST") == null){
      db.createDefaultlist();
    }else {
      db.loadData();
    }
    super.initState();
  }

  //reference hivebox
  final _myBox = Hive.box("myBox");

  ToDoDatabase db = ToDoDatabase();


//text controller
  final textcontroller = TextEditingController();

// onchange function of checkbox
  void checkboxChanged ( bool? value, index){
    setState(() {
      db.todoList[index][1]=!db.todoList[index][1];
    });
    db.updateData();
  }

// creates a new task
  void createNewTask(){
    showDialog(context: context, builder: (context){
      return DialogBox(
        controller: textcontroller,
        OnSave:(){
          setState(() {
            db.todoList.add([textcontroller.text,false]);
            textcontroller.clear();
          });
          Navigator.of(context).pop();
          db.updateData();
        },
        OnCancel: (){
          textcontroller.clear();
          Navigator.of(context).pop();
        },
      );
    });
  }

//deletes a task
  void deleteThisTask(int index){
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.yellow.shade100,

      appBar: AppBar(
        title: const Text("ToDo"),
        centerTitle: true,
        backgroundColor: Colors.yellow,
        elevation: 0,
      ),

      body:ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
              taskValue: db.todoList[index][1],
              taskName: db.todoList[index][0],
              onChanged:(value) => checkboxChanged(value,index),
            deleteFunction:(context) => deleteThisTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          backgroundColor: Colors.yellow,
          child: const Icon(Icons.add)
      ),

    );
  }
}
