import 'package:movieapp/shared/models/movie_details.dart';

sealed class MovieDetailsState {
  const MovieDetailsState();
}

class MovieDetailsInitial extends MovieDetailsState {
  const MovieDetailsInitial();
}

class MovieDetailsLoading extends MovieDetailsState {
  const MovieDetailsLoading();
}

class MovieDetailsLoaded extends MovieDetailsState {
  const MovieDetailsLoaded(this.movie);

  final MovieDetails movie;
}

class MovieDetailsError extends MovieDetailsState {
  const MovieDetailsError(this.message);

  final String message;
}
