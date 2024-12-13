class Joke {
  final String type;
  final String setup;
  final String punchline;

  Joke({
    required this.type,
    required this.setup,
    required this.punchline,
  });

  Joke.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        setup = json['setup'],
        punchline = json['punchline'];

  Map<String, dynamic> toJson() => {
        'type': type,
        'setup': setup,
        'punchline': punchline,
      };
}
