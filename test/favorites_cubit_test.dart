import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movieapp/features/favorites/cubit/favorites_cubit.dart';
import 'package:movieapp/features/favorites/cubit/favorites_state.dart';
import 'package:movieapp/features/favorites/data/favorites_repository.dart';
import 'package:movieapp/features/favorites/models/favorite_movie.dart';

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

void main() {
  late MockFavoritesRepository repository;

  const movie = FavoriteMovie(id: 1, title: 'Dune', posterPath: '/dune.jpg');

  setUp(() {
    repository = MockFavoritesRepository();
    registerFallbackValue(<FavoriteMovie>[]);
  });

  group('FavoritesCubit', () {
    blocTest<FavoritesCubit, FavoritesState>(
      'load emits movies from repository',
      setUp: () {
        when(() => repository.getAll()).thenAnswer((_) async => [movie]);
      },
      build: () => FavoritesCubit(repository),
      act: (cubit) => cubit.load(),
      expect: () => [
        isA<FavoritesLoading>(),
        isA<FavoritesLoaded>().having((s) => s.movies, 'movies', [movie]),
      ],
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'toggle adds a movie when it is not in favorites',
      setUp: () {
        when(() => repository.saveAll(any())).thenAnswer((_) async {});
      },
      build: () => FavoritesCubit(repository),
      seed: () => const FavoritesLoaded([]),
      act: (cubit) => cubit.toggle(movie),
      expect: () => [
        isA<FavoritesLoaded>()
            .having((s) => s.movies, 'movies', [movie])
            .having((s) => s.isFavorite(movie.id), 'isFavorite', true),
      ],
      verify: (_) {
        verify(() => repository.saveAll([movie])).called(1);
      },
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'toggle removes a movie when it is already in favorites',
      setUp: () {
        when(() => repository.saveAll(any())).thenAnswer((_) async {});
      },
      build: () => FavoritesCubit(repository),
      seed: () => const FavoritesLoaded([movie]),
      act: (cubit) => cubit.toggle(movie),
      expect: () => [
        isA<FavoritesLoaded>()
            .having((s) => s.movies, 'movies', isEmpty)
            .having((s) => s.isFavorite(movie.id), 'isFavorite', false),
      ],
    );
  });
}
