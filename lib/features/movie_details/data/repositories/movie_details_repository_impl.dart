import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/api_result.dart';
import 'package:movies/core/utils/app_errors.dart';
import 'package:movies/core/utils/extensions/connectivity_extension.dart';
import 'package:movies/features/movie_details/data/mappers/movie_details_mapper.dart';
import 'package:movies/features/movie_details/data/models/movie_details_response.dart';
import 'package:movies/features/movie_details/data/repositories/data_sources/movie_details_data_source/movie_details_data_source.dart';
import 'package:movies/features/movie_details/domain/models/movie_details.dart';
import 'package:movies/features/movie_details/domain/repository/movie_details_repository.dart';
@Injectable(as: MovieDetailsRepository)
class MovieDetailsRepositoryImpl extends MovieDetailsRepository {
  final MovieDetailsDataSource _movieDetailsDataSource;
  final Connectivity _connectivity;
  final MovieDetailsMapper _mapper;
  MovieDetailsRepositoryImpl(this._movieDetailsDataSource,this._connectivity,this._mapper);
  @override
  Future<ApiResult<MovieDetails>>loadMovieDetails(int id)async{
    if(await _connectivity.isConnected){
      var apiResult= await _movieDetailsDataSource.loadMovieDetails(id);
      if(apiResult.isSuccess){
        RemoteMovieDetails remoteMovieDetails=apiResult.getData()!;
        return SuccessApiResult(_mapper.toMovieDetails(remoteMovieDetails));
      }else{
        return ErrorApiResult(apiResult.error);
      }
    }else{
      return ErrorApiResult(NetworkErrors(errorMessage: "Check your internet connection!"));
    }

  }
}