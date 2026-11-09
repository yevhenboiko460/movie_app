class FavoriteMovie {
  const FavoriteMovie({
    required this.id,
    required this.title,
    required this.posterPath,
  });

  final int id;
  final String title;
  final String? posterPath;

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'posterPath': posterPath};
  }

  factory FavoriteMovie.fromJson(Map<String, dynamic> json) {
    return FavoriteMovie(
      id: json['id'] as int,
      title: json['title'] as String,
      posterPath: json['posterPath'] as String?,
    );
  }
}
