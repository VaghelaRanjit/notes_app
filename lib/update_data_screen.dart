import 'package:flutter/material.dart';

import 'models/notes_model.dart';

class UpdateDataScreen extends StatefulWidget {
  final NotesModel notesModel;

  const UpdateDataScreen({super.key, required this.notesModel});

  @override
  State<UpdateDataScreen> createState() => _UpdateDataScreenState();
}

class _UpdateDataScreenState extends State<UpdateDataScreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  // TextEditingController titleController = TextEditingController();
  // TextEditingController descController = TextEditingController();

  @override
  void initState() {
    super.initState();

    titleController.text = widget.notesModel.title;
    descController.text = widget.notesModel.description;
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UPDATE YOUR NOTES '),
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
                  borderSide: BorderSide(color: Colors.black),
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
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),

            SizedBox(height: 20),

            GestureDetector(
              onTap: () async {
                if (titleController.text.isNotEmpty &&
                    descController.text.isNotEmpty) {
                  await updateData(widget.notesModel); // pass note here
                }
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

  Future<void> updateData(NotesModel notesModel) async {
    // Update values from controllers
    notesModel.title = titleController.text;
    notesModel.description = descController.text;

    // Save updated object
    await notesModel.save();

    // Go back
    Navigator.pop(context);
  }
}
