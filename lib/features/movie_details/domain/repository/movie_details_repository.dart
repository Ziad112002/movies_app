import '../../../../core/utils/api_result.dart';
import '../../../navigation/domain/models/movie.dart';
import '../models/movie_details.dart';

abstract class MovieDetailsRepository {
  Future<ApiResult<MovieDetails>>loadMovieDetails(int id);
  Future<ApiResult<List<Movie>>>loadSimilarMovies(int id);

}