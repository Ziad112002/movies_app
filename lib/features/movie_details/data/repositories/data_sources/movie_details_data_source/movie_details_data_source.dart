import 'package:movies/core/utils/api_result.dart';
import '../../../../../navigation/data/models/remote_movie.dart';
import '../../../models/movie_details_response.dart';
import '../models/stored_movie_model.dart';

abstract class MovieDetailsDataSource {
  Future<ApiResult<RemoteMovieDetails>> loadMovieDetails(int id);
  Future<ApiResult<List<RemoteMovie>>>loadSimilarMovies(int id);
  Future<ApiResult<void>>toggleMovieInFireStore(StoredMovieModel movie,String collectionName,bool isExist);
  Future<ApiResult<bool>>checkMovieExists(int movieID,String collectionName);
}