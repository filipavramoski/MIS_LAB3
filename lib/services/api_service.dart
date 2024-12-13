import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/joke.dart';

class ApiService {
  static Future<List<String>> getJokeTypes() async {
    final response = await http
        .get(Uri.parse("https://official-joke-api.appspot.com/types"));
    if (response.statusCode == 200) {
      print("Response: ${response.body}");
      return List<String>.from(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch joke types!");
    }
  }

  static Future<List<Joke>> getJokesByType(String type) async {
    final response = await http.get(
        Uri.parse("https://official-joke-api.appspot.com/jokes/$type/ten"));
    if (response.statusCode == 200) {
      print("Response: ${response.body}");
      final data = jsonDecode(response.body) as List;
      return data.map((joke) => Joke.fromJson(joke)).toList();
    } else {
      throw Exception("Failed to fetch jokes of type $type!");
    }
  }

  static Future<Joke> getRandomJoke() async {
    final response = await http
        .get(Uri.parse("https://official-joke-api.appspot.com/random_joke"));
    if (response.statusCode == 200) {
      print("Response: ${response.body}");
      return Joke.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch random joke!");
    }
  }
}
