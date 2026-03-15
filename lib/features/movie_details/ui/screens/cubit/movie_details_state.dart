import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/resource.dart';
import 'package:movies/features/movie_details/domain/models/movie_details.dart';
import 'package:movies/features/navigation/domain/models/movie.dart';
@injectable
class MovieDetailsState {
  late Resource<MovieDetails>movieDetailsApi;
  late Resource<List<Movie>>similarMoviesApi;
  late Resource<void>createMovieServer;
  late Resource<bool>checkMovieServer;

  MovieDetailsState(
      {required this.movieDetailsApi, required this.similarMoviesApi,required this.createMovieServer,required this.checkMovieServer});

  MovieDetailsState.initial(){
    movieDetailsApi = Resource.initial();
    similarMoviesApi = Resource.initial();
    createMovieServer = Resource.initial();
    checkMovieServer = Resource.initial();
  }

  MovieDetailsState copyWith({
    Resource<MovieDetails>?movieDetailsApi,
    Resource<List<Movie>>?similarMoviesApi,
    Resource<void>?createMovieServer,
    Resource<bool>?checkMovieServer,
  }) {
    return MovieDetailsState(
        movieDetailsApi: movieDetailsApi ?? this.movieDetailsApi,
        similarMoviesApi: similarMoviesApi ?? this.similarMoviesApi,
        createMovieServer:createMovieServer??this.createMovieServer,
        checkMovieServer:checkMovieServer??this.checkMovieServer
    );
  }
}
