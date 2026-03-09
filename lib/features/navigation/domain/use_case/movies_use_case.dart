import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/api_result.dart';
import 'package:movies/features/navigation/domain/models/movie.dart';
import 'package:movies/features/navigation/domain/repository/movies_repository.dart';
@injectable
class MoviesUseCase {
final MoviesRepository _moviesRepository;
MoviesUseCase(this._moviesRepository);
  Future<ApiResult<List<Movie>>>call(   int? limit,
      int? page,
      String? genre,
      String? queryTerm,
      String? sortBy,
      String? orderBy,
      int? minimumRating,) {
  return _moviesRepository.loadMovies(    limit,
  page,
   genre,
   queryTerm,
 sortBy,
     orderBy,
   minimumRating,);
}
}