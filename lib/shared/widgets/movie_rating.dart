import 'package:flutter/material.dart';

class MovieRating extends StatelessWidget {
  const MovieRating({
    super.key,
    required this.rating,
    this.iconSize = 16,
    this.fontSize = 14,
    this.fontWeight = FontWeight.bold,
    this.spacing = 8,
  });

  final double rating;
  final double iconSize;
  final double fontSize;
  final FontWeight fontWeight;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: spacing,
      children: [
        Icon(Icons.star, color: Colors.amber, size: iconSize),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
        ),
      ],
    );
  }
}
