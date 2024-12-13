import 'package:flutter/material.dart';
import '../models/joke.dart';
import '../services/api_service.dart';
import '../widgets/details/detail_back_button.dart';
import '../widgets/details/detail_data.dart';
import '../widgets/details/detail_title.dart';

class JokeDetails extends StatefulWidget {
  const JokeDetails({super.key});

  @override
  State<JokeDetails> createState() => _JokeDetailsState();
}

class _JokeDetailsState extends State<JokeDetails> {
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

class JokesByTypeScreen extends StatefulWidget {
  final String type;

  const JokesByTypeScreen({super.key, required this.type});

  @override
  State<JokesByTypeScreen> createState() => _JokesByTypeState();
}

class _JokesByTypeState extends State<JokesByTypeScreen> {
  List<Joke> jokes = [];
  String currentType = '';

  @override
  void initState() {
    super.initState();
    currentType = widget.type;
    getJokesFromAPI();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (currentType != widget.type) {
      setState(() {
        currentType = widget.type;
        getJokesFromAPI();
      });
    }
  }

  void getJokesFromAPI() async {
    try {
      final response = await ApiService.getJokesByType(currentType);
      setState(() {
        jokes = List.from(response);
      });
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[100],
        title: Text(
          '$currentType Jokes',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: jokes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                final joke = jokes[index];
                return ListTile(
                  title: Text(joke.setup),
                  subtitle: Text(joke.punchline),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const JokeDetails(),
                        settings: RouteSettings(arguments: joke),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
