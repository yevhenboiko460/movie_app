import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/network/movie_api_service.dart';
import '../features/favorites/screens/favorites_screen.dart';
import '../features/home/cubit/home_cubit.dart';
import '../features/home/screens/home_screen.dart';
import '../features/movie_details/cubit/movie_details_cubit.dart';
import '../features/movie_details/screens/movie_details_screen.dart';
import '../features/search/cubit/search_cubit.dart';
import '../features/search/screens/search_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => BlocProvider(
        create: (context) => HomeCubit(context.read<MovieApiService>())..loadPopularMovies(),
        child: const HomeScreen(),
      ),
    ),
    GoRoute(
      path: '/search',
      name: 'search',
      builder: (context, state) => BlocProvider(
        create: (context) => SearchCubit(context.read<MovieApiService>()),
        child: const SearchScreen(),
      ),
    ),
    GoRoute(
      path: '/favorites',
      name: 'favorites',
      builder: (context, state) => const FavoritesScreen(),
    ),
    GoRoute(
      path: '/movie/:id',
      name: 'movie-details',
      builder: (context, state) {
        final movieId = int.parse(state.pathParameters['id']!);

        return BlocProvider(
          create: (context) =>
              MovieDetailsCubit(context.read<MovieApiService>())..loadMovieDetails(movieId),
          child: MovieDetailsScreen(movieId: movieId),
        );
      },
    ),
  ],
);
