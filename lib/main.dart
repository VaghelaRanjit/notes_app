import 'package:flutter/material.dart';
// import 'package:hive/hive.dart'; // need with path provider
import 'package:hive_flutter/hive_flutter.dart';
import 'home_screen.dart';
import 'models/notes_model.dart';

//import 'package:path_provider/path_provider.dart';// for more complex apps

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // var directory = await getApplicationDocumentsDirectory();
  // Hive.init(directory.path);

  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>('notes');




  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // theme: ThemeData.dark(),

      home: HomeScreen(), // your screen here
    );
  }
}
