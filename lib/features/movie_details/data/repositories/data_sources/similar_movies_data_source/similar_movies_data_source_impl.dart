import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/api_result.dart';
import 'package:movies/core/utils/app_errors.dart';
import 'package:movies/features/movie_details/data/repositories/data_sources/similar_movies_data_source/similar_movies_data_source.dart';
import 'package:movies/features/navigation/data/models/remote_movie.dart';
import 'package:movies/features/network/api_client/api_client.dart';

import '../../../../../navigation/data/models/movies_response.dart';
@Injectable(as: SimilarMoviesDataSource)
class SimilarMoviesDataSourceImpl extends SimilarMoviesDataSource {
  final ApiClient _apiClient;
  SimilarMoviesDataSourceImpl(this._apiClient);
  @override
  Future<ApiResult<List<RemoteMovie>>>loadSimilarMovies(int id)async {
    try {
      MoviesResponse moviesResponse = await _apiClient.loadSimilarMovies(id);
      List<RemoteMovie> movies = moviesResponse.data.movies;
      return SuccessApiResult(movies);
    } on Exception catch (e) {
      return ErrorApiResult(UnKnownErrors(errorMessage: e.toString()));
    }
  }
}