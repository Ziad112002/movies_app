import '../../../../core/utils/api_result.dart';
import '../models/movie_details.dart';

abstract class MovieDetailsRepository {
  Future<ApiResult<MovieDetails>>loadMovieDetails(int id);
}