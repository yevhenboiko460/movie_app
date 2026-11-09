import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movieapp/shared/widgets/app_drawer.dart';
import 'package:movieapp/shared/widgets/movie_card.dart';

import '../cubit/search_cubit.dart';
import '../cubit/search_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _search() {
    FocusScope.of(context).unfocus();
    context.read<SearchCubit>().search(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: Colors.orange,
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              spacing: 8,
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (_) => _search(),
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: 'Search movies',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                  ),
                ),
                FilledButton(
                  onPressed: _search,
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: const Size(0, 56),
                  ),
                  child: const Text('Search'),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                return switch (state) {
                  SearchEmpty() => const Center(
                    child: Text('Start typing to search'),
                  ),
                  SearchLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  SearchError(:final message) => Center(child: Text(message)),
                  SearchLoaded(movies: final movies) when movies.isEmpty =>
                    const Center(child: Text('Nothing found')),
                  SearchLoaded(:final movies) => GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: movies.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisExtent: 340,
                        ),
                    itemBuilder: (context, index) {
                      final movie = movies[index];

                      return MovieCard(
                        key: ValueKey(movie.id),
                        id: movie.id,
                        title: movie.title,
                        posterPath: movie.posterPath,
                        releaseDate: movie.releaseDate,
                        voteAverage: movie.voteAverage,
                      );
                    },
                  ),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}
