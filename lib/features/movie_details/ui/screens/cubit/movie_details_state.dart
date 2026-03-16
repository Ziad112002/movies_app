import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/resource.dart';
import 'package:movies/features/movie_details/domain/models/movie_details.dart';
import 'package:movies/features/navigation/domain/models/movie.dart';
@injectable
class MovieDetailsState {
  late Resource<MovieDetails>movieDetailsApi;
  late Resource<List<Movie>>similarMoviesApi;
  late Resource<void>toggleMovieServer;
  late Resource<bool>checkMovieServer;

  MovieDetailsState(
      {required this.movieDetailsApi, required this.similarMoviesApi,required this.toggleMovieServer,required this.checkMovieServer});

  MovieDetailsState.initial(){
    movieDetailsApi = Resource.initial();
    similarMoviesApi = Resource.initial();
    toggleMovieServer = Resource.initial();
    checkMovieServer = Resource.initial();
  }

  MovieDetailsState copyWith({
    Resource<MovieDetails>?movieDetailsApi,
    Resource<List<Movie>>?similarMoviesApi,
    Resource<bool>?toggleMovieServer,
    Resource<bool>?checkMovieServer,
  }) {
    return MovieDetailsState(
        movieDetailsApi: movieDetailsApi ?? this.movieDetailsApi,
        similarMoviesApi: similarMoviesApi ?? this.similarMoviesApi,
        toggleMovieServer:toggleMovieServer??this.toggleMovieServer,
        checkMovieServer:checkMovieServer??this.checkMovieServer
    );
  }
}
