import 'package:flutter/material.dart';
import '../../data/models/joke_model.dart';

class JokeCard extends StatelessWidget {
  final JokeModel joke;

  const JokeCard({super.key, required this.joke});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          joke.fullText,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
