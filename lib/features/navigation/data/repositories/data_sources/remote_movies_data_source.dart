import 'package:movies/core/utils/api_result.dart';
import 'package:movies/features/movie_details/data/repositories/data_sources/models/stored_movie_model.dart';
import 'package:movies/features/navigation/data/models/remote_movie.dart';

abstract class RemoteMoviesDataSource {
  Future<ApiResult<List<RemoteMovie>>> loadMovies(
      int? limit,
      int? page,
      String? genre,
      String? queryTerm,
      String? sortBy,
      String? orderBy,
      int? minimumRating,
      );
  Future<ApiResult<List<StoredMovieModel>>> loadMoviesFromFirestore(String collectionName);

}