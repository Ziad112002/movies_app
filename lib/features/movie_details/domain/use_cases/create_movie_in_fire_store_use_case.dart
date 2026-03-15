import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/api_result.dart';
import 'package:movies/features/movie_details/data/repositories/data_sources/models/stored_movie_model.dart';
import 'package:movies/features/movie_details/domain/repository/movie_details_repository.dart';

@injectable
class CreateMovieInFireStoreUseCase {
  final MovieDetailsRepository _repo;
  CreateMovieInFireStoreUseCase(this._repo);
  Future<ApiResult<void>>call(StoredMovieModel movie,String collectionName)async{
    return await _repo.createMovieInFirestore(movie, collectionName);
  }
}