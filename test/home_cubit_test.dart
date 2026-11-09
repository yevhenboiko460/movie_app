import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movieapp/core/network/movie_api_service.dart';
import 'package:movieapp/features/home/cubit/home_cubit.dart';
import 'package:movieapp/features/home/cubit/home_state.dart';
import 'package:movieapp/shared/models/movie.dart';
import 'package:movieapp/shared/models/paged_response.dart';

class MockMovieApiService extends Mock implements MovieApiService {}

Movie _movie(int id) {
  return Movie(
    id: id,
    title: 'Movie $id',
    posterPath: null,
    releaseDate: '2024-01-01',
    voteAverage: 7.5,
  );
}

PagedResponse<Movie> _page(int id, {int page = 1, int totalPages = 2}) {
  return PagedResponse(items: [_movie(id)], page: page, totalPages: totalPages);
}

void main() {
  late MockMovieApiService api;

  setUp(() {
    api = MockMovieApiService();
  });

  group('HomeCubit', () {
    blocTest<HomeCubit, HomeState>(
      'loadPopularMovies emits the first page',
      setUp: () {
        when(() => api.getPopularMovies()).thenAnswer((_) async => _page(1));
      },
      build: () => HomeCubit(api),
      act: (cubit) => cubit.loadPopularMovies(),
      expect: () => [
        isA<HomeLoading>(),
        isA<HomeLoaded>()
            .having((s) => s.movies.length, 'movies.length', 1)
            .having((s) => s.page, 'page', 1)
            .having((s) => s.hasMore, 'hasMore', true)
            .having((s) => s.isLoadingMore, 'isLoadingMore', false),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'loadMore appends the next page and advances the page counter',
      setUp: () {
        when(() => api.getPopularMovies(page: 2))
            .thenAnswer((_) async => _page(2, page: 2, totalPages: 2));
      },
      build: () => HomeCubit(api),
      seed: () => HomeLoaded(movies: [_movie(1)], page: 1, hasMore: true),
      act: (cubit) => cubit.loadMore(),
      expect: () => [
        isA<HomeLoaded>().having((s) => s.isLoadingMore, 'isLoadingMore', true),
        isA<HomeLoaded>()
            .having((s) => s.isLoadingMore, 'isLoadingMore', false)
            .having((s) => s.movies.length, 'movies.length', 2)
            .having((s) => s.page, 'page', 2)
            .having((s) => s.hasMore, 'hasMore', false),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'loadMore does nothing when there are no more pages',
      build: () => HomeCubit(api),
      seed: () => const HomeLoaded(movies: [], page: 3, hasMore: false),
      act: (cubit) => cubit.loadMore(),
      expect: () => <HomeState>[],
      verify: (_) {
        verifyNever(() => api.getPopularMovies(page: any(named: 'page')));
      },
    );
  });
}
