import 'package:movies/core/utils/api_result.dart';
import '../models/movie.dart';

abstract class MoviesRepository {
  Future<ApiResult<List<Movie>>> loadMovies();
}