import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'boxes/boxes.dart';
import 'models/favorite_model.dart';


class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Notes"),
      ),
      body: ValueListenableBuilder(
        valueListenable: Boxes.getFavorites().listenable(),
        builder: (context, Box<FavoriteModel> box, _) {

          final favorites = box.values.toList();

          if (favorites.isEmpty) {
            return const Center(
              child: Text("No favorite notes"),
            );
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {

              final note = favorites[index];

              return Card(
                child: ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.description),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
