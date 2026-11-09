import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/movie_details_cubit.dart';
import '../cubit/movie_details_state.dart';
import '../widgets/movie_backdrop.dart';
import '../widgets/movie_info_card.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key, required this.movieId});

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
        backgroundColor: Colors.orange,
      ),
      body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
        builder: (context, state) {
          return switch (state) {
            MovieDetailsInitial() => const SizedBox.shrink(),
            MovieDetailsLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            MovieDetailsError(:final message) => Center(child: Text(message)),
            MovieDetailsLoaded(:final movie) => SingleChildScrollView(
              child: Column(
                children: [
                  if (movie.backdropPath != null)
                    MovieBackdrop(backdropPath: movie.backdropPath!),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Transform.translate(
                      offset: const Offset(0, -50),
                      child: MovieInfoCard(movie: movie),
                    ),
                  ),
                ],
              ),
            ),
          };
        },
      ),
    );
  }
}
