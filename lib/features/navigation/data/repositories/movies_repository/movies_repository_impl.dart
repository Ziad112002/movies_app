import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/api_result.dart';
import 'package:movies/core/utils/app_errors.dart';
import 'package:movies/features/network/api_client/api_client.dart';
import 'package:movies/features/network/models/movies_response.dart';
import 'package:movies/features/network/models/remote_movie.dart';

import 'movies_repository.dart';
@Injectable(as: MoviesRepository)
class MoviesRepositoryImpl {
  final ApiClient _apiClient;
  MoviesRepositoryImpl(this._apiClient);
  Future<ApiResult<List<Movie>>> loadMovies()async{
   try {
     MoviesResponse moviesResponse= await _apiClient.loadMovies();
     List<Movie>movies=moviesResponse.data.movies;
     return SuccessApiResult(movies);
   } on Exception catch (e) {
     return ErrorApiResult(UnKnownErrors());
   }
  }
}