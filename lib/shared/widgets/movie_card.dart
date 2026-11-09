import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'movie_rating.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.title,
    required this.posterPath,
    required this.id,
    this.releaseDate,
    this.voteAverage,
  });

  final String title;
  final String? posterPath;
  final String? releaseDate;
  final double? voteAverage;
  final int id;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          'movie-details',
          pathParameters: {'id': id.toString()},
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 250,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: posterPath != null
                  ? Image.network(
                      'https://image.tmdb.org/t/p/w500$posterPath',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image);
                      },
                    )
                  : const Icon(Icons.movie),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          if (releaseDate != null) ...[
            const SizedBox(height: 4),
            Text(releaseDate!, style: const TextStyle(fontSize: 12)),
          ],
          if (voteAverage != null) ...[
            const SizedBox(height: 6),
            MovieRating(rating: voteAverage!),
          ],
        ],
      ),
    );
  }
}
