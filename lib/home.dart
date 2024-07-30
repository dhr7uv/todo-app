import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/todotile.dart';
import 'database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //text controller
  TextEditingController textController = TextEditingController();
  FirestoreServices firestoreServices = FirestoreServices();
  bool _taskValue = false;

  // function to create a new note
  void addNote(){
    showDialog(
      context: context,
      builder: (context)=>AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          ElevatedButton(
              onPressed: (){
                // add a new note
                firestoreServices.addNotes(textController.text);

                // clears the text field
                textController.clear();
                Navigator.pop(context);
              },
              child: const Text("Add"),
          ),
        ],
      ));
  }

  // function to update a note
  void updateNote(String docId){
    showDialog(
      context: context,
      builder: (context)=>AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          ElevatedButton(
              onPressed: (){
                // update a note
                firestoreServices.updateNotes(textController.text, docId);

                // clears the text field
                textController.clear();
                Navigator.pop(context);
              },
              child: const Text("Edit"),
          ),
        ],
      ));
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

      body: StreamBuilder<QuerySnapshot>(
          stream: firestoreServices.getNotesStream(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              // list to contain the documents
              List notesList = snapshot.data!.docs;

              // list for checkboxes
              // List<bool> checkList = List.filled(notesList.length,false);

              return ListView.builder(itemCount: notesList.length, itemBuilder: (context, index) {

                // getting each document individually
                DocumentSnapshot document = notesList[index];
                String docId = document.id;

                // getting data from the document
                Map<String,dynamic> data = document.data() as Map<String,dynamic>;

                // storing the note value from the data
                String noteText = data['note'];

                // display note in todoTile
                return TodoTile(
                  taskName: noteText,
                  taskValue: _taskValue,
                  updateFunction: ()=> updateNote(docId),
                  deleteFunction:()=> firestoreServices.deleteNotes(docId),
                );
              }
              );
            } else{
              return const Center(child: Text("no notes..."));
            }
          },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: ()=>addNote(),
        backgroundColor: Colors.yellow.shade400,
        child: const Icon(Icons.add),
      ),

    );
  }
}
