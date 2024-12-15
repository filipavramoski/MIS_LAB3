import 'package:flutter/material.dart';
import '../models/joke.dart';
import '../widgets/details/detail_back_button.dart';
import '../widgets/details/detail_data.dart';
import '../widgets/details/detail_title.dart';
import '../services/api_service.dart';

class JokeDetails extends StatelessWidget {
  const JokeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final joke = ModalRoute.of(context)?.settings.arguments as Joke?;

    if (joke == null)
      return const Center(child: Text('Joke details not available'));

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            DetailTitle(type: joke.type),
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
  _JokesByTypeScreenState createState() => _JokesByTypeScreenState();
}

class _JokesByTypeScreenState extends State<JokesByTypeScreen> {
  late List<Joke> jokes;

  @override
  void initState() {
    super.initState();
    jokes = [];
    _fetchJokes();
  }

  void _fetchJokes() async {
    try {
      final response = await ApiService.getJokesByType(widget.type);
      setState(() {
        jokes = List.from(response);
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[100],
        title: Text('${widget.type} Jokes'),
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
                        builder: (context) => JokeDetails(),
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
