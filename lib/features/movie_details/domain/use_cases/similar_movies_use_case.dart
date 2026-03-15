import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/api_result.dart';
import 'package:movies/features/movie_details/domain/repository/movie_details_repository.dart';
import 'package:movies/features/navigation/domain/models/movie.dart';
@injectable
class SimilarMoviesUseCase {
  final MovieDetailsRepository _repo;
  SimilarMoviesUseCase(this._repo);
  Future<ApiResult<List<Movie>>>call(int id)async{
    return _repo.loadSimilarMovies(id);
  }
}