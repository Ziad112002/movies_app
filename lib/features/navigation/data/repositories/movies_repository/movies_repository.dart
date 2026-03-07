import 'package:movies/core/utils/api_result.dart';
import 'package:movies/features/network/models/remote_movie.dart';

abstract class MoviesRepository {
  Future<ApiResult<List<Movie>>> loadMovies();

}