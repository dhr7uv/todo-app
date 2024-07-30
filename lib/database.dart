import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices{

  // get the collection of notes
  final CollectionReference notes = FirebaseFirestore.instance.collection('notes');

  // Create
  Future<void> addNotes(String note){
    return notes.add({
      'note' : note,
      'timestamp' : Timestamp.now(),
      'checkVal' : false,
    });
  }

  // Read
  Stream<QuerySnapshot> getNotesStream(){
    final notesList = notes.orderBy('timestamp',descending: true).snapshots();
    return notesList;
  }

  // Update
  Future<void> updateNotes(String newNote, String docId){
    return notes.doc(docId).update({
      'note' : newNote,
      'timestamp' : Timestamp.now(),
    });
  }

  // Delete
  Future<void> deleteNotes(String docId){
    return notes.doc(docId).delete();
  }
}
