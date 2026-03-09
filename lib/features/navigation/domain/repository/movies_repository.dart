import 'package:movies/core/utils/api_result.dart';
import '../models/movie.dart';

abstract class MoviesRepository {
  Future<ApiResult<List<Movie>>> loadMovies(   int? limit,
      int? page,
      String? genre,
      String? queryTerm,
      String? sortBy,
      String? orderBy,
      int? minimumRating,);
}