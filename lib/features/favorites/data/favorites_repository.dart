import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/favorite_movie.dart';

class FavoritesRepository {
  static const String _key = 'favorite_movies';

  Future<List<FavoriteMovie>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);

    if (raw == null) return [];

    return (jsonDecode(raw) as List)
        .map((json) => FavoriteMovie.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveAll(List<FavoriteMovie> movies) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(movies.map((movie) => movie.toJson()).toList());

    await prefs.setString(_key, raw);
  }
}
