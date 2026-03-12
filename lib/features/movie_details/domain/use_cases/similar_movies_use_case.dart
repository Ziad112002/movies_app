import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/api_result.dart';
import 'package:movies/features/movie_details/domain/repository/similar_movies_repository.dart';
import 'package:movies/features/navigation/domain/models/movie.dart';
@injectable
class SimilarMoviesUseCase {
  final SimilarMoviesRepository _similarMoviesRepository;
  SimilarMoviesUseCase(this._similarMoviesRepository);
  Future<ApiResult<List<Movie>>>call(int id)async{
    return _similarMoviesRepository.loadSimilarMovies(id);
  }
}