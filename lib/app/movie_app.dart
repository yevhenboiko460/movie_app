import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/network/movie_api_service.dart';
import '../features/favorites/cubit/favorites_cubit.dart';
import '../features/favorites/data/favorites_repository.dart';
import '../router/app_router.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({
    super.key,
    required this.movieApiService,
    required this.favoritesRepository,
  });

  final MovieApiService movieApiService;
  final FavoritesRepository favoritesRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: movieApiService),
        RepositoryProvider.value(value: favoritesRepository),
      ],
      child: BlocProvider(
        create: (context) =>
            FavoritesCubit(context.read<FavoritesRepository>())..load(),
        child: MaterialApp.router(routerConfig: appRouter),
      ),
    );
  }
}
