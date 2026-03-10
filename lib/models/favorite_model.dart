import 'package:hive/hive.dart';

part 'favorite_model.g.dart';

@HiveType(typeId: 1) //  Make sure NotesModel is typeId: 0
class FavoriteModel extends HiveObject {

  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  FavoriteModel({
    required this.title,
    required this.description,
  });
}
