import '../../../../core/utils/api_result.dart';
import '../../../navigation/domain/models/movie.dart';

abstract class SimilarMoviesRepository {
  Future<ApiResult<List<Movie>>>loadSimilarMovies(int id);
}