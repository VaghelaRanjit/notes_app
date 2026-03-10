import 'package:flutter/material.dart';
import 'package:hive_db_notes_app/add_note_screen.dart';
import 'package:hive_db_notes_app/models/notes_model.dart';
import 'package:hive_db_notes_app/update_data_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'boxes/boxes.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final searchController = TextEditingController();
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        extendBody: true,

        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Keep Notes ✏️",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
        ),

            body: ValueListenableBuilder<Box<NotesModel>>(
              valueListenable: Boxes.getNotes().listenable(),
              builder: (context, box, _) {
                var data = box.values.toList().cast<NotesModel>();

                if (data.isEmpty) {
                  return const Center(
                    child: Text(
                      "No Notes Available",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                return GridView.builder(
                  itemCount: data.length,
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 8,
                      color: Colors.cyanAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    data[index].title.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),

                                /// DELETE
                                InkWell(
                                  onTap: () {
                                    deleteUndo(data[index]);
                                  },
                                  child: const Icon(Icons.delete, color: Colors.red),
                                ),

                                const SizedBox(width: 10),

                                /// EDIT
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateDataScreen(notesModel: data[index]),
                                      ),
                                    );
                                  },
                                  child: const Icon(Icons.edit),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            Expanded(
                              child: Text(
                                data[index].description.toString(),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),

            /// CENTER BUTTON
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.cyanAccent,
              foregroundColor: Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddNoteScreen()),
                );
              },
              child: const Icon(Icons.add),
            ),

            /// BOTTOM TAB BAR
            bottomNavigationBar: BottomAppBar(
              color: Colors.black,
              shape: const CircularNotchedRectangle(),
              notchMargin: 8,
              child: SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// HOME
                    IconButton(
                      icon: const Icon(Icons.home, color: Colors.white),
                      onPressed: () {},
                    ),

                    const SizedBox(width: 40),

                    /// FAVORITES
                    IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FavoritesScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }



        void deleteUndo(NotesModel notesModel) {
          final box = Boxes.getNotes();

          final backupNote = NotesModel(
            title: notesModel.title,
            description: notesModel.description,
          );

          final messenger = ScaffoldMessenger.of(context);

          messenger.clearSnackBars();

          messenger.showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              content: const Text("Note deleted"),
              action: SnackBarAction(
                label: "UNDO",
                onPressed: () {
                  box.add(backupNote);
                },
              ),
            ),
          );

          box.delete(notesModel.key);
        }

        /// SIMPLE DELETE
        void deleteData(NotesModel notesModel) {
          final box = Boxes.getNotes();
          box.delete(notesModel.key);
        }


  }


