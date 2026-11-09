import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/movie_api_service.dart';
import 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit(this._movieApiService) : super(const MovieDetailsInitial());

  final MovieApiService _movieApiService;

  Future<void> loadMovieDetails(int id) async {
    emit(const MovieDetailsLoading());

    try {
      final movie = await _movieApiService.getMovieDetails(id);
      emit(MovieDetailsLoaded(movie));
    } catch (error) {
      emit(MovieDetailsError(error.toString()));
    }
  }
}
