import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/movie_api_service.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._movieApiService) : super(const SearchEmpty());

  final MovieApiService _movieApiService;

  Future<void> search(String value) async {
    final query = value.trim();

    if (query.isEmpty) {
      emit(const SearchEmpty());
      return;
    }

    emit(SearchLoading(query));

    try {
      final page = await _movieApiService.searchMovies(query);

      if (query != state.query) return;

      emit(SearchLoaded(query, page.items));
    } catch (error) {
      if (query != state.query) return;

      emit(SearchError(query, error.toString()));
    }
  }
}
