import 'package:movies/features/network/models/remote_movie.dart';

abstract class MoviesRepository {
  Future<List<Movie>> loadMovies();

}