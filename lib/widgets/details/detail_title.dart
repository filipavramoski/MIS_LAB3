import 'package:flutter/material.dart';

class DetailTitle extends StatelessWidget {
  final String type;

  const DetailTitle({required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        '$type Jokes',
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
