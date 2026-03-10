import 'package:flutter/material.dart';

import 'boxes/boxes.dart';
import 'models/notes_model.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD NOTES HERE'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.black,
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Enter the Title',

                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextFormField(
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.black,
              controller: descController,
              decoration: InputDecoration(
                hintText: 'Enter the Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
              ),
            ),

            SizedBox(height: 20),

            GestureDetector(
              onTap: () {
                addData();
              },
              child: Container(
                height: 50,
                width: 380,
                decoration: BoxDecoration(
                  color: Colors.cyanAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text('Save', style: TextStyle(fontSize: 20)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addData() {
    final title = titleController.text.trim();
    final desc = descController.text.trim();
    if (title.isEmpty && desc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Please enter title or description"),
        ),
      );
      return; // stop empty note from saving
    } else if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Please Enter title"),
        ),
      );
      return;
    }

    if (desc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Please Enter Description"),
        ),
      );
      return;
    }

    final data = NotesModel(
      title: titleController.text.trim(),
      description: descController.text.trim(),
    );

    final box = Boxes.getNotes();
    box.add(data);

    // data.save();

    // print(box);
    titleController.clear();
    descController.clear();

    Navigator.pop(context);
  }
}
