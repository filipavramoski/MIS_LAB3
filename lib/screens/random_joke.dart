import 'package:flutter/material.dart';
import '../models/joke.dart';
import '../services/api_service.dart';
import '../widgets/details/detail_back_button.dart';
import '../widgets/details/detail_data.dart';
import '../widgets/details/detail_title.dart';
import 'details.dart';

class RandomJokeScreen extends StatefulWidget {
  const RandomJokeScreen({super.key});

  @override
  _RandomJokeScreenState createState() => _RandomJokeScreenState();
}

class _RandomJokeScreenState extends State<RandomJokeScreen> {
  Joke? randomJoke;

  @override
  void initState() {
    super.initState();
    _fetchRandomJoke();
  }

  void _fetchRandomJoke() async {
    try {
      final joke = await ApiService.getRandomJoke();
      setState(() {
        randomJoke = joke;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[100],
        title: const Text('Random Joke'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchRandomJoke,
          ),
        ],
      ),
      body: randomJoke == null
          ? const Center(child: CircularProgressIndicator())
          : InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JokeDetails(),
                    settings: RouteSettings(arguments: randomJoke),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(randomJoke!.setup,
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 20),
                    Text(randomJoke!.punchline,
                        style: const TextStyle(fontSize: 24)),
                    const SizedBox(height: 20),
                    const Text('Tap to see more details'),
                  ],
                ),
              ),
            ),
    );
  }
}
