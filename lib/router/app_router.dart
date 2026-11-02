import 'package:go_router/go_router.dart';

import '../screens/favorites_screen.dart';
import '../screens/home_screen.dart';
// import '../screens/movie_details_screen.dart';
import '../screens/search_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/search',
      name: 'search',
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: '/favorites',
      name: 'favorites',
      builder: (context, state) => const FavoritesScreen(),
    ),
    // GoRoute(
    //   path: '/movie/:id',
    //   name: 'movie-details',
    //   builder: (context, state) {
    //     final movieId = state.pathParameters['id']!;
    //     return MovieDetailsScreen(movieId: movieId);
    //   },
    // ),
  ],
);
