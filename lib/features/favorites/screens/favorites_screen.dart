import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movieapp/shared/widgets/app_drawer.dart';
import 'package:movieapp/shared/widgets/movie_card.dart';

import '../cubit/favorites_cubit.dart';
import '../cubit/favorites_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites movies'),
        backgroundColor: Colors.orange,
      ),
      drawer: const AppDrawer(),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          return switch (state) {
            FavoritesInitial() || FavoritesLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            FavoritesError(:final message) => Center(child: Text(message)),
            FavoritesLoaded(movies: final movies) when movies.isEmpty =>
              const Center(child: Text('Empty')),
            FavoritesLoaded(:final movies) => GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: movies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisExtent: 310,
              ),
              itemBuilder: (context, index) {
                final movie = movies[index];

                return MovieCard(
                  key: ValueKey(movie.id),
                  id: movie.id,
                  title: movie.title,
                  posterPath: movie.posterPath,
                );
              },
            ),
          };
        },
      ),
    );
  }
}
