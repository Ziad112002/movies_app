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
      movieCount: json['movie_count'] ??0,
      limit: json['limit'] ??0,
      pageNumber: json['page_number'] ??0,
      movies: (json['movies'] as List<dynamic>? ??[])
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
