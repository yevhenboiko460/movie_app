import 'package:flutter/material.dart';

class MovieGenres extends StatelessWidget {
  const MovieGenres({super.key, required this.genres});

  final List<String> genres;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: genres.map((genre) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.orange.shade100,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            genre,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        );
      }).toList(),
    );
  }
}
