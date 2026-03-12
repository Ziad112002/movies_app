import 'package:movies/core/utils/api_result.dart';
import 'package:movies/features/navigation/data/models/remote_movie.dart';

abstract class SimilarMoviesDataSource {
  Future<ApiResult<List<RemoteMovie>>>loadSimilarMovies(int id);
}