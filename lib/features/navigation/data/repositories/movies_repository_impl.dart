import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/api_result.dart';
import 'package:movies/core/utils/app_errors.dart';
import 'package:movies/core/utils/extensions/connectivity_extension.dart';
import 'package:movies/features/navigation/data/mapper/movies_mapper.dart';
import 'package:movies/features/navigation/data/repositories/data_sources/remote_movies_data_source.dart';
import 'package:movies/features/navigation/domain/models/movie.dart';
import 'package:movies/features/navigation/domain/repository/movies_repository.dart';

import '../../../movie_details/data/repositories/data_sources/models/stored_movie_model.dart';

@Injectable(as: MoviesRepository)
class MoviesRepositoryImpl extends MoviesRepository {
  final Connectivity _connectivity;
  final MoviesMapper _mapper;
  final RemoteMoviesDataSource _remoteMoviesDataSource;
  MoviesRepositoryImpl(
    this._connectivity,
    this._remoteMoviesDataSource,
    this._mapper,
  );

  @override
  Future<ApiResult<List<Movie>>> loadMovies(
    int? limit,
    int? page,
    String? genre,
    String? queryTerm,
    String? sortBy,
    String? orderBy,
    int? minimumRating,
  ) async {
    if (await _connectivity.isConnected) {
      var apiResult = await _remoteMoviesDataSource.loadMovies(
        limit,
        page,
        genre,
        queryTerm,
        sortBy,
        orderBy,
        minimumRating,
      );
      if (apiResult.isSuccess) {
        var remoteMovies = apiResult.getData();
        return SuccessApiResult(_mapper.getMovies(remoteMovies ?? []));
      } else {
        return ErrorApiResult(apiResult.error);
      } // List<Movie> movies=_mapper.getMovies(  as List<RemoteMovie>) ;
      //  return SuccessApiResult(movies);
    } else {
      return ErrorApiResult(NetworkErrors());
    }
  }
  @override
  Future<ApiResult<List<StoredMovieModel>>> loadMoviesFromFirestore(String collectionName) async{
    if (await _connectivity.isConnected) {
      final result = await _remoteMoviesDataSource.loadMoviesFromFirestore(collectionName);
      if (result.isSuccess) {

        return SuccessApiResult(result.getData()??[]);
      } else {
        return ErrorApiResult(result.error);
      }
    } else {
      return ErrorApiResult(NetworkErrors());
    }
  }

}
