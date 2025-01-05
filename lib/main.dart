import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lab2_211063/screens/favorites.dart';
import 'screens/details.dart';
import 'screens/random_joke.dart';
import 'screens/home.dart';
import 'firebase_options.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
  
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase initialized successfully");

   
    await FirebaseApi().initNotification();
    print("Notifications initialized successfully");

    
    runApp(const MyApp());
  } catch (e) {
    
    print("Error initializing Firebase or notifications: $e");

   
 
  }
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
      home: const Home(),
      routes: {
        '/home': (context) => const Home(),
        '/random': (context) => const RandomJokeScreen(),
        '/favorites': (context) => const FavoritesScreen()
      },
    );
  }
}
