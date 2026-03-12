import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/api_result.dart';
import 'package:movies/features/movie_details/domain/models/movie_details.dart';
import 'package:movies/features/movie_details/domain/repository/movie_details_repository.dart';
@injectable
class MovieDetailsUseCase {
 final MovieDetailsRepository _movieDetailsRepository;
 MovieDetailsUseCase(this._movieDetailsRepository);
 Future<ApiResult<MovieDetails>>call(int id){
   return _movieDetailsRepository.loadMovieDetails(id);
 }
}