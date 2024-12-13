import 'package:flutter/material.dart';
import '../models/joke.dart';
import '../services/api_service.dart';
import '../widgets/details/detail_back_button.dart';
import '../widgets/details/detail_data.dart';
import '../widgets/details/detail_title.dart';

class RandomJokeDetails extends StatefulWidget {
  const RandomJokeDetails({super.key});

  @override
  State<RandomJokeDetails> createState() => _RandomJokeDetailsState();
}

class _RandomJokeDetailsState extends State<RandomJokeDetails> {
  Joke joke = Joke(setup: '', punchline: '', type: '');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments as Joke;
    getJokeDetails(arguments);
  }

  void getJokeDetails(Joke selectedJoke) async {
    setState(() {
      joke = selectedJoke;
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Joke;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DetailTitle(type: arguments.type),
            DetailData(joke: joke),
          ],
        ),
      ),
      floatingActionButton: const DetailBackButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

class RandomJokeScreen extends StatefulWidget {
  const RandomJokeScreen({super.key});

  @override
  State<RandomJokeScreen> createState() => _RandomJokeScreenState();
}

class _RandomJokeScreenState extends State<RandomJokeScreen> {
  Joke? randomJoke;

  @override
  void initState() {
    super.initState();
    getRandomJokeFromAPI();
  }

  void getRandomJokeFromAPI() async {
    try {
      final response = await ApiService.getRandomJoke();
      setState(() {
        randomJoke = response;
      });
    } catch (error) {
      print("Error fetching random joke: $error");
    }
  }

  void refreshJoke() {
    getRandomJokeFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[100],
        title: const Text('Random Joke',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: refreshJoke,
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
                    builder: (context) => const RandomJokeDetails(),
                    settings: RouteSettings(arguments: randomJoke),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      randomJoke!.setup,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      randomJoke!.punchline,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Tap to see more details',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
