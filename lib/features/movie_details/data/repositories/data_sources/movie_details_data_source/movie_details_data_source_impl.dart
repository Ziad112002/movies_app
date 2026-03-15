import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/api_result.dart';
import 'package:movies/core/utils/app_errors.dart';
import 'package:movies/features/movie_details/data/models/movie_details_response.dart';
import 'package:movies/features/network/api_client/api_client.dart';

import '../../../../../navigation/data/models/movies_response.dart';
import '../../../../../navigation/data/models/remote_movie.dart';
import 'movie_details_data_source.dart';
@Injectable(as: MovieDetailsDataSource)
class MovieDetailsDataSourceImpl extends MovieDetailsDataSource  {
  final ApiClient _apiClient;
  MovieDetailsDataSourceImpl(this._apiClient);
  @override
  Future<ApiResult<RemoteMovieDetails>> loadMovieDetails(int id)async{
    try {
      var movieDetailsResponse=await _apiClient.loadMovieDetails(id);
      RemoteMovieDetails? remoteMovieDetails=movieDetailsResponse.data!.movie;
      return SuccessApiResult(remoteMovieDetails);
    } on Exception catch (e) {
      return ErrorApiResult(UnKnownErrors(errorMessage: e.toString()));
    }
  }
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