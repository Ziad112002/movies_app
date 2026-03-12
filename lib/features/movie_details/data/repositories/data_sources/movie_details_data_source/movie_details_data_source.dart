import 'package:movies/core/utils/api_result.dart';
import '../../../models/movie_details_response.dart';

abstract class MovieDetailsDataSource {
  Future<ApiResult<RemoteMovieDetails>> loadMovieDetails(int id);
}