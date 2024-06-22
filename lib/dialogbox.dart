import 'package:flutter/material.dart';
import 'package:todo_app/buttons.dart';


class DialogBox extends StatelessWidget {

  final controller;
  final VoidCallback OnSave;
  final VoidCallback OnCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.OnSave,
    required this.OnCancel
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: Container(
        height: 140,
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
          //for user input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Add a new task",
                border: OutlineInputBorder()
              ),
            ),

          //save and cancel buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  MyButton(text: "Save", OnPressed: OnSave),
                  //for spacing
                  const SizedBox(width: 10),

                  MyButton(text: "Cancel", OnPressed: OnCancel)
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
