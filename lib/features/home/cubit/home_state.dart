import 'package:movieapp/shared/models/movie.dart';

sealed class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeError extends HomeState {
  const HomeError(this.message);

  final String message;
}

class HomeLoaded extends HomeState {
  const HomeLoaded({
    required this.movies,
    required this.page,
    required this.hasMore,
    this.isLoadingMore = false,
  });

  final List<Movie> movies;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;

  HomeLoaded copyWith({
    List<Movie>? movies,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return HomeLoaded(
      movies: movies ?? this.movies,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}
