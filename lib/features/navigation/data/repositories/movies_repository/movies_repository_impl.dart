import 'package:injectable/injectable.dart';
import 'package:movies/features/network/api_client/api_client.dart';
import 'package:movies/features/network/models/movies_response.dart';
import 'package:movies/features/network/models/remote_movie.dart';

import 'movies_repository.dart';
@Injectable(as: MoviesRepository)
class MoviesRepositoryImpl {
   ApiClient _apiClient;
  MoviesRepositoryImpl(this._apiClient);
  Future<List<Movie>> loadMovies()async{
   MoviesResponse moviesResponse= await _apiClient.loadMovies();
   List<Movie>movies=moviesResponse.data.movies;
   return movies;
  }
}