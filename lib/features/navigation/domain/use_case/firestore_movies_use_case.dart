import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/api_result.dart';
import 'package:movies/features/movie_details/data/repositories/data_sources/models/stored_movie_model.dart';
import 'package:movies/features/navigation/domain/repository/movies_repository.dart';
@injectable
class FirestoreMoviesUseCase {
  final MoviesRepository _repos;
  FirestoreMoviesUseCase(this._repos);
  Future<ApiResult<List<StoredMovieModel>>>call(String collectionName)async{
    return await _repos.loadMoviesFromFirestore(collectionName);
  }
}