import '../../../../core/utils/api_result.dart';
import '../../../navigation/domain/models/movie.dart';
import '../../data/repositories/data_sources/models/stored_movie_model.dart';
import '../models/movie_details.dart';

abstract class MovieDetailsRepository {
  Future<ApiResult<MovieDetails>>loadMovieDetails(int id);
  Future<ApiResult<List<Movie>>>loadSimilarMovies(int id);
  Future<ApiResult<void>> createMovieInFirestore(StoredMovieModel movie,String collectionName);
  Future<ApiResult<bool>>checkMovieExists(int movieID,String collectionName);


  }