import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/features/home/cubit/home_cubit.dart';
import 'package:movieapp/features/home/cubit/home_state.dart';
import 'package:movieapp/shared/widgets/app_drawer.dart';
import 'package:movieapp/shared/widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const double _loadMoreOffset = 300;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent - _loadMoreOffset) {
      context.read<HomeCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App'),
        backgroundColor: Colors.orange,
      ),
      drawer: const AppDrawer(),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return switch (state) {
            HomeInitial() ||
            HomeLoading() => const Center(child: CircularProgressIndicator()),
            HomeError(:final message) => Center(child: Text(message)),
            HomeLoaded(movies: final movies) when movies.isEmpty =>
              const Center(child: Text('No movies found')),
            HomeLoaded(:final movies, :final isLoadingMore) => CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(12),
                  sliver: SliverGrid.builder(
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
                        title: movie.title,
                        posterPath: movie.posterPath,
                        releaseDate: movie.releaseDate,
                        voteAverage: movie.voteAverage,
                        key: ValueKey(movie.id),
                        id: movie.id,
                      );
                    },
                  ),
                ),
                if (isLoadingMore)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
              ],
            ),
          };
        },
      ),
    );
  }
}
