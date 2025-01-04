import 'package:flutter/material.dart';
import '../models/joke.dart';
import '../services/api_service.dart';
import '../widgets/details/detail_back_button.dart';
import '../widgets/details/detail_data.dart';
import '../widgets/details/detail_title.dart';
import 'details.dart';
import 'favorites.dart';

class RandomJokeScreen extends StatefulWidget {
  const RandomJokeScreen({super.key});

  @override
  State<RandomJokeScreen> createState() => _RandomJokeScreenState();
}

class _RandomJokeScreenState extends State<RandomJokeScreen> {
  Joke? currentJoke;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRandomJoke();
  }

  Future<void> _loadRandomJoke() async {
    setState(() => isLoading = true);
    final joke = await ApiService.getRandomJoke();
    setState(() {
      currentJoke = joke;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Joke'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    currentJoke?.setup ?? '',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    currentJoke?.punchline ?? '',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          FavoritesScreen.favoriteJokes
                                  .any((j) => j.setup == currentJoke?.setup)
                              ? Icons.favorite
                              : Icons.favorite_border,
                        ),
                        onPressed: () {
                          setState(() {
                            if (currentJoke != null) {
                              if (FavoritesScreen.favoriteJokes
                                  .any((j) => j.setup == currentJoke?.setup)) {
                                FavoritesScreen.favoriteJokes.removeWhere(
                                    (j) => j.setup == currentJoke?.setup);
                              } else {
                                FavoritesScreen.favoriteJokes.add(currentJoke!);
                              }
                            }
                          });
                        },
                      ),
                      ElevatedButton(
                        onPressed: _loadRandomJoke,
                        child: const Text('Next Joke'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
