import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/services/firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //firestore
  final FirestoreService firestoreService = FirestoreService();

  // text controller
  final TextEditingController textController = TextEditingController();

  // open dialog vox to add a note
  void openNoteBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              firestoreService.addNote(textController.text);
              textController.clear();
              Navigator.pop(context);
            },
            child: Text("Add"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(backgroundColor: Colors.lightBlueAccent,  title: Center(
        child: Text(
          "Notes",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20, //
          ),
        ),
      ),
        elevation: 0, //
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        backgroundColor: Colors.lightBlueAccent,
        child: const Icon(Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getNotesStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List notesList = snapshot.data?.docs ?? [];

            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = notesList[index];
                String docID = document.id;

                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String noteText = data['note'];

                return ListTile(
                  title: Text(noteText),
                );
              },
            );

          }
          else {
            return const Text("No notes...");
          }
        }
      ),
    );
  }
}
