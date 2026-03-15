import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/api_result.dart';
import 'package:movies/features/movie_details/domain/repository/movie_details_repository.dart';
@injectable
class CheckMovieExistsUseCase {
  final MovieDetailsRepository _repos;
  CheckMovieExistsUseCase(this._repos);
  Future<ApiResult<bool>>call(int movieId,String collectionName)async{
    return await _repos.checkMovieExists(movieId, collectionName);
  }
}