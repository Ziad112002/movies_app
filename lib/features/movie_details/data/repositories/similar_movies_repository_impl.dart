import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/api_result.dart';
import 'package:movies/core/utils/app_errors.dart';
import 'package:movies/core/utils/extensions/connectivity_extension.dart';
import 'package:movies/features/movie_details/data/repositories/data_sources/similar_movies_data_source/similar_movies_data_source.dart';
import 'package:movies/features/movie_details/domain/repository/similar_movies_repository.dart';
import 'package:movies/features/navigation/data/mapper/movies_mapper.dart';
import 'package:movies/features/navigation/domain/models/movie.dart';
@Injectable(as: SimilarMoviesRepository)
class SimilarMoviesRepositoryImpl extends SimilarMoviesRepository {
  final Connectivity _connectivity;
  final MoviesMapper _mapper;
  final SimilarMoviesDataSource _similarMoviesDataSource;
  SimilarMoviesRepositoryImpl(this._connectivity,this._mapper,this._similarMoviesDataSource);
  @override
  Future<ApiResult<List<Movie>>>loadSimilarMovies(int id)async{
    if(await _connectivity.isConnected){
      var result=await _similarMoviesDataSource.loadSimilarMovies(id);
      if(result.isSuccess){
        List<Movie>movies=_mapper.getMovies(result.getData()??[]);
        return SuccessApiResult(movies);
      }else{
        return ErrorApiResult(result.error);
      }
    }else{
      return ErrorApiResult(NetworkErrors());
    }
  }

}