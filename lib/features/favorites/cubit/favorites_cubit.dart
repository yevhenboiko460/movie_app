import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/favorites_repository.dart';
import '../models/favorite_movie.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this._repository) : super(const FavoritesInitial());

  final FavoritesRepository _repository;

  Future<void> load() async {
    emit(const FavoritesLoading());

    try {
      final movies = await _repository.getAll();

      emit(FavoritesLoaded(movies));
    } catch (error) {
      emit(FavoritesError(error.toString()));
    }
  }

  Future<void> toggle(FavoriteMovie movie) async {
    final currentState = state;
    if (currentState is! FavoritesLoaded) return;

    final movies = currentState.isFavorite(movie.id)
        ? currentState.movies.where((m) => m.id != movie.id).toList()
        : [...currentState.movies, movie];

    emit(FavoritesLoaded(movies));

    try {
      await _repository.saveAll(movies);
    } catch (error) {
      emit(FavoritesError(error.toString()));
    }
  }
}
