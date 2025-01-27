import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  // Create note
  Future<void> addNote(String note) {
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }


  //Read note
  Stream<QuerySnapshot> getNotesStream() {
    final noteStream =
        notes.orderBy('timestamp', descending: true).snapshots();
    return noteStream;
  }
}