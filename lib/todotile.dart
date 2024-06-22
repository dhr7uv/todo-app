import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  TodoTile({
    super.key,
    required this.taskValue,
    required this.taskName,
    required this.onChanged,
    required this.deleteFunction
  });

  final String taskName;
  final bool taskValue;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:25.0,top:25.0,right:25.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(onPressed: deleteFunction,
              backgroundColor: Colors.red,
              icon: Icons.delete,
            )
          ]
        ),
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(color: Colors.yellow),
        
          child: Row(
            children: [
              Checkbox(value: taskValue, onChanged: onChanged,activeColor: Colors.black87),
              Text(taskName,style: TextStyle(
                decoration: taskValue ? TextDecoration.lineThrough : TextDecoration.none
              )),
            ],
          ),
        ),
      ),
    );
  }
}
