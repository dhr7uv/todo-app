import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatefulWidget {
  TodoTile({
    super.key,
    required this.taskValue,
    required this.taskName,
    required this.updateFunction,
    required this.deleteFunction,
  });

  final String taskName;
  bool taskValue;
  void Function()? updateFunction;
  void Function()? deleteFunction;

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:25.0,top:25.0,right:25.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          extentRatio: 0.20,
          children: [
            IconButton(onPressed: widget.deleteFunction,icon: const Icon(Icons.delete),color: Colors.red,),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(color: Colors.yellow),
          child: Row(
            children: [
              Checkbox(
                  value: widget.taskValue,
                  onChanged: (value){
                    setState(() {
                      widget.taskValue = value as bool;
                    });
                  },
                  activeColor: Colors.black87
              ),

              Expanded(
                flex: 2,
                child: Text(widget.taskName,style: TextStyle(
                  decoration: widget.taskValue ? TextDecoration.lineThrough : TextDecoration.none
                )),
              ),
              IconButton(onPressed: widget.updateFunction,icon: const Icon(Icons.edit),),
            ],
          ),
        ),
      ),
    );
  }
}
