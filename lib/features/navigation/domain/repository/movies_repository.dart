import 'package:movies/core/utils/api_result.dart';
import '../../../movie_details/data/repositories/data_sources/models/stored_movie_model.dart';
import '../models/movie.dart';

abstract class MoviesRepository {
  Future<ApiResult<List<Movie>>> loadMovies(   int? limit,
      int? page,
      String? genre,
      String? queryTerm,
      String? sortBy,
      String? orderBy,
      int? minimumRating,);
  Future<ApiResult<List<StoredMovieModel>>> loadMoviesFromFirestore(String collectionName);

}