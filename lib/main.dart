import 'package:flutter/material.dart';
import 'screens/details.dart';
import 'screens/random_joke.dart';
import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokes App - 211063',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueAccent[100],
          foregroundColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/randomJoke': (context) => const RandomJokeScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/jokesByType') {
          final type = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => JokesByTypeScreen(type: type),
          );
        }
        return null;
      },
    );
  }
}
