class Movie {
  const Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
  });

  final int id;
  final String title;
  final String? posterPath;
  final String releaseDate;
  final double voteAverage;

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] as String? ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0,
    );
  }
}
