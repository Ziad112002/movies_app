import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/resource.dart';
import 'package:movies/features/movie_details/data/repositories/data_sources/models/stored_movie_model.dart';
import 'package:movies/features/navigation/domain/models/movie.dart';
@injectable
class MoviesState {
  late Resource<List<Movie>>moviesApi;
  late Resource<List<StoredMovieModel>>moviesServer;
  MoviesState({required this.moviesApi,required this.moviesServer});
  MoviesState.initial(){
    moviesApi=Resource.initial();
    moviesServer=Resource.initial();
  }
  MoviesState copyWith({
    Resource<List<Movie>>?moviesApi,
    Resource<List<StoredMovieModel>>?moviesServer
}){
    return MoviesState(moviesApi: moviesApi??this.moviesApi, moviesServer: moviesServer??this.moviesServer);
  }
}