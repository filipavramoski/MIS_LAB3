import 'package:flutter/material.dart';
import '../models/joke.dart';
import '../services/api_service.dart';
import 'favorites.dart';
import 'details.dart';

class JokesByTypeScreen extends StatefulWidget {
  final String type;

  const JokesByTypeScreen({super.key, required this.type});

  @override
  State<JokesByTypeScreen> createState() => _JokesByTypeScreenState();
}

class _JokesByTypeScreenState extends State<JokesByTypeScreen> {
  List<Joke> jokes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadJokes();
  }

  Future<void> _loadJokes() async {
    final loadedJokes = await ApiService.getJokesByType(widget.type);
    setState(() {
      jokes = loadedJokes;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.type} Jokes'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                final joke = jokes[index];
                return ListTile(
                  title: Text(joke.setup),
                  subtitle: Text(joke.punchline),
                  trailing: IconButton(
                    icon: Icon(
                      FavoritesScreen.favoriteJokes
                              .any((j) => j.setup == joke.setup)
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                    onPressed: () {
                      setState(() {
                        if (FavoritesScreen.favoriteJokes
                            .any((j) => j.setup == joke.setup)) {
                          FavoritesScreen.favoriteJokes
                              .removeWhere((j) => j.setup == joke.setup);
                        } else {
                          FavoritesScreen.favoriteJokes.add(joke);
                        }
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            FavoritesScreen.favoriteJokes
                                    .any((j) => j.setup == joke.setup)
                                ? 'Added to favorites'
                                : 'Removed from favorites',
                          ),
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JokeDetails(joke: joke),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
