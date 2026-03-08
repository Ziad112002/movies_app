import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/api_result.dart';
import 'package:movies/core/utils/app_errors.dart';
import 'package:movies/core/utils/extensions/connectivity_extension.dart';
import 'package:movies/features/navigation/data/mapper/movies_mapper.dart';
import 'package:movies/features/navigation/data/repositories/data_sources/remote_movies_data_source.dart';
import 'package:movies/features/navigation/domain/models/movie.dart';
import 'package:movies/features/navigation/domain/repository/movies_repository.dart';
@Injectable(as: MoviesRepository)
class MoviesRepositoryImpl extends MoviesRepository {
  final Connectivity _connectivity;
  final MoviesMapper _mapper;
  final RemoteMoviesDataSource _remoteMoviesDataSource;
  MoviesRepositoryImpl(this._connectivity,this._remoteMoviesDataSource,this._mapper);

  @override
  Future<ApiResult<List<Movie>>> loadMovies()async{
    if(await _connectivity.isConnected){
      var apiResult=await _remoteMoviesDataSource.loadMovies();
      if (apiResult.isSuccess) {
        var remoteMovies = apiResult.getData();
        return SuccessApiResult(
          _mapper.getMovies(remoteMovies?? []),
        );
      } else {
        return ErrorApiResult(apiResult.error);
      }// List<Movie> movies=_mapper.getMovies(  as List<RemoteMovie>) ;
     //  return SuccessApiResult(movies);
    }else{
      return ErrorApiResult(NetworkErrors());
    }

  }
}