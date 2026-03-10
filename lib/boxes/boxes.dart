// import 'package:hive/hive.dart';
// import 'package:hive_db_notes_app/models/notes_model.dart';
//
// class Boxes {
//   static Box<NotesModel> getData() => Hive.box<NotesModel>('notes');
//
// }

import 'package:hive/hive.dart';
import '../models/notes_model.dart';
import '../models/favorite_model.dart';

class Boxes {
  static Box<NotesModel> getNotes() => Hive.box<NotesModel>('notes');

  static Box<FavoriteModel> getFavorites() => Hive.box<FavoriteModel>('favorites');
}
