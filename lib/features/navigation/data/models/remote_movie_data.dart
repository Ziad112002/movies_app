import 'remote_movie.dart';

class MovieData {
  final int movieCount;
  final int limit;
  final int pageNumber;
  final List<RemoteMovie> movies;

  const MovieData({
    required this.movieCount,
    required this.limit,
    required this.pageNumber,
    required this.movies,
  });

  factory MovieData.fromJson(Map<String, dynamic> json) {
    return MovieData(
      movieCount: json['movie_count'] as int,
      limit: json['limit'] as int,
      pageNumber: json['page_number'] as int,
      movies: (json['movies'] as List<dynamic>)
          .map((e) => RemoteMovie.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'movie_count': movieCount,
    'limit': limit,
    'page_number': pageNumber,
    'movies': movies.map((e) => e.toJson()).toList(),
  };
}
