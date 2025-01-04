import 'package:flutter/material.dart';
import '../models/joke.dart';

class FavoritesScreen extends StatefulWidget {
  static final List<Joke> favoriteJokes = [];
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Jokes'),
        backgroundColor: const Color.fromARGB(255, 143, 130, 255),
      ),
      body: FavoritesScreen.favoriteJokes.isEmpty
          ? const Center(child: Text("No favorite jokes right now"))
          : ListView.builder(
              itemCount: FavoritesScreen.favoriteJokes.length,
              itemBuilder: (context, index) {
                final joke = FavoritesScreen.favoriteJokes[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(joke.setup),
                    subtitle: Text(joke.punchline),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          FavoritesScreen.favoriteJokes.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
