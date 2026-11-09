import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../shared/models/movie.dart';
import '../../shared/models/movie_details.dart';
import '../../shared/models/paged_response.dart';

class MovieApiService {
  MovieApiService({required this._client, required this._accessToken});

  static const String _baseUrl = 'https://api.themoviedb.org/3';

  final http.Client _client;
  final String _accessToken;

  Future<PagedResponse<Movie>> getPopularMovies({int page = 1}) async {
    final uri = Uri.parse('$_baseUrl/movie/popular')
        .replace(queryParameters: {'page': page.toString()});

    final json = await _get(uri, 'Failed to load popular movies');

    return _parseMoviePage(json, fallbackPage: page);
  }

  Future<PagedResponse<Movie>> searchMovies(
    String query, {
    int page = 1,
  }) async {
    final uri = Uri.parse('$_baseUrl/search/movie')
        .replace(queryParameters: {'query': query, 'page': page.toString()});

    final json = await _get(uri, 'Failed to search movies');

    return _parseMoviePage(json, fallbackPage: page);
  }

  Future<MovieDetails> getMovieDetails(int id) async {
    final uri = Uri.parse('$_baseUrl/movie/$id');

    final json = await _get(uri, 'Failed to load movie details');

    return MovieDetails.fromJson(json);
  }

  Future<Map<String, dynamic>> _get(Uri uri, String errorMessage) async {
    final response = await _client.get(
      uri,
      headers: {
        'Authorization': 'Bearer $_accessToken',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('$errorMessage: ${response.statusCode}');
    }

    return jsonDecode(response.body);
  }

  PagedResponse<Movie> _parseMoviePage(
    Map<String, dynamic> json, {
    required int fallbackPage,
  }) {
    final results = ((json['results'] as List?) ?? [])
        .map((item) => Movie.fromJson(item as Map<String, dynamic>))
        .toList();

    return PagedResponse(
      items: results,
      page: json['page'] as int? ?? fallbackPage,
      totalPages: json['total_pages'] as int? ?? fallbackPage,
    );
  }
}
