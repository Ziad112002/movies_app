import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/api_result.dart';
import 'package:movies/core/utils/app_errors.dart';
import 'package:movies/features/network/api_client/api_client.dart';
import 'package:movies/features/navigation/data/models/movies_response.dart';
import 'package:movies/features/navigation/data/models/remote_movie.dart';

import 'remote_movies_data_source.dart';

@Injectable(as: RemoteMoviesDataSource)
class RemoteMoviesDataSourceImpl extends RemoteMoviesDataSource {
  final ApiClient _apiClient;
  RemoteMoviesDataSourceImpl(this._apiClient);
  @override
  Future<ApiResult<List<RemoteMovie>>> loadMovies(
    int? limit,
    int? page,
    String? genre,
    String? queryTerm,
    String? sortBy,
    String? orderBy,
    int? minimumRating,
  ) async {
    try {
      MoviesResponse moviesResponse = await _apiClient.loadMovies(limit,page,genre,queryTerm,sortBy,orderBy,minimumRating);
      List<RemoteMovie> movies = moviesResponse.data.movies;
      return SuccessApiResult(movies);
    } on Exception catch (e) {
      return ErrorApiResult(UnKnownErrors(errorMessage: e.toString()));
    }
  }
}
