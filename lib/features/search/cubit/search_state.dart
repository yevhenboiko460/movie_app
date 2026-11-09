import 'package:movieapp/shared/models/movie.dart';

sealed class SearchState {
  const SearchState();

  String get query;
}

class SearchEmpty extends SearchState {
  const SearchEmpty();

  @override
  String get query => '';
}

class SearchLoading extends SearchState {
  const SearchLoading(this.query);

  @override
  final String query;
}

class SearchError extends SearchState {
  const SearchError(this.query, this.message);

  @override
  final String query;
  final String message;
}

class SearchLoaded extends SearchState {
  const SearchLoaded(this.query, this.movies);

  @override
  final String query;
  final List<Movie> movies;
}
