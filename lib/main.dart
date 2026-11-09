import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'app/movie_app.dart';
import 'core/network/movie_api_service.dart';
import 'features/favorites/data/favorites_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  final movieApiService = MovieApiService(
    client: http.Client(),
    accessToken: dotenv.env['TMDB_ACCESS_TOKEN'] ?? '',
  );
  final favoritesRepository = FavoritesRepository();

  runApp(
    MovieApp(
      movieApiService: movieApiService,
      favoritesRepository: favoritesRepository,
    ),
  );
}
