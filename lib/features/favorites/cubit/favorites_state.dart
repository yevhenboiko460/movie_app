import '../models/favorite_movie.dart';

sealed class FavoritesState {
  const FavoritesState();
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial();
}

class FavoritesLoading extends FavoritesState {
  const FavoritesLoading();
}

class FavoritesError extends FavoritesState {
  const FavoritesError(this.message);

  final String message;
}

class FavoritesLoaded extends FavoritesState {
  const FavoritesLoaded(this.movies);

  final List<FavoriteMovie> movies;

  bool isFavorite(int id) => movies.any((movie) => movie.id == id);
}
