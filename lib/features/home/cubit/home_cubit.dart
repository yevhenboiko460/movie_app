import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/movie_api_service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._movieApiService) : super(const HomeInitial());

  final MovieApiService _movieApiService;

  Future<void> loadPopularMovies() async {
    emit(const HomeLoading());

    try {
      final page = await _movieApiService.getPopularMovies();

      emit(
        HomeLoaded(movies: page.items, page: page.page, hasMore: page.hasMore),
      );
    } catch (error) {
      emit(HomeError(error.toString()));
    }
  }

  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is! HomeLoaded ||
        currentState.isLoadingMore ||
        !currentState.hasMore) {
      return;
    }

    emit(currentState.copyWith(isLoadingMore: true));

    try {
      final nextPage = currentState.page + 1;
      final page = await _movieApiService.getPopularMovies(page: nextPage);

      emit(
        currentState.copyWith(
          movies: [...currentState.movies, ...page.items],
          page: page.page,
          hasMore: page.hasMore,
          isLoadingMore: false,
        ),
      );
    } catch (_) {
      emit(currentState.copyWith(isLoadingMore: false));
    }
  }
}
