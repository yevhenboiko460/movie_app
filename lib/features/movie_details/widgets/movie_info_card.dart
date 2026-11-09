import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../favorites/cubit/favorites_cubit.dart';
import '../../favorites/cubit/favorites_state.dart';
import '../../favorites/models/favorite_movie.dart';

import 'package:movieapp/shared/models/movie_details.dart';
import 'package:movieapp/shared/widgets/movie_rating.dart';

import 'movie_genres.dart';

class MovieInfoCard extends StatelessWidget {
  const MovieInfoCard({super.key, required this.movie});

  final MovieDetails movie;

  String _formatRuntime(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;

    if (hours == 0) return '${mins}m';
    if (mins == 0) return '${hours}h';
    return '${hours}h ${mins}m';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            spacing: 12,
            children: [
              if (movie.posterPath != null)
                Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  height: 250,
                  fit: BoxFit.cover,
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    MovieRating(
                      rating: movie.voteAverage,
                      iconSize: 20,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      spacing: 6,
                    ),
                    if (movie.runtime != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.schedule,
                            size: 18,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            _formatRuntime(movie.runtime!),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 12),
                    MovieGenres(genres: movie.genres),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 18),
          Text(
            movie.overview,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, state) {
                  final isFavorite =
                      state is FavoritesLoaded && state.isFavorite(movie.id);

                  return ElevatedButton.icon(
                    onPressed: () => context.read<FavoritesCubit>().toggle(
                      FavoriteMovie(
                        id: movie.id,
                        title: movie.title,
                        posterPath: movie.posterPath,
                      ),
                    ),
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    label: Text(
                      isFavorite ? 'Remove from favorites' : 'Add to favorites',
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
