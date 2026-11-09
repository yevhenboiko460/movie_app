import 'package:flutter/material.dart';

class MovieBackdrop extends StatelessWidget {
  const MovieBackdrop({super.key, required this.backdropPath});

  final String backdropPath;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://image.tmdb.org/t/p/w1280$backdropPath',
      height: 250,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
