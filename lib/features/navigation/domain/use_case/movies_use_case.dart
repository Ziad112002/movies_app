import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/api_result.dart';
import 'package:movies/features/navigation/domain/models/movie.dart';
import 'package:movies/features/navigation/domain/repository/movies_repository.dart';
@injectable
class MoviesUseCase {
final MoviesRepository _moviesRepository;
MoviesUseCase(this._moviesRepository);
  Future<ApiResult<List<Movie>>>call() {
  return _moviesRepository.loadMovies();
}
}