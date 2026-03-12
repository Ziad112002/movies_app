import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/resource.dart';
import 'package:movies/features/movie_details/domain/models/movie_details.dart';
import 'package:movies/features/navigation/domain/models/movie.dart';
@injectable
class MovieDetailsState {
  late Resource<MovieDetails>movieDetailsApi;
  late Resource<List<Movie>>similarMoviesApi;

  MovieDetailsState(
      {required this.movieDetailsApi, required this.similarMoviesApi});

  MovieDetailsState.initial(){
    movieDetailsApi = Resource.initial();
    similarMoviesApi = Resource.initial();
  }

  MovieDetailsState copyWith({
    Resource<MovieDetails>?movieDetailsApi,
    Resource<List<Movie>>?similarMoviesApi
  }) {
    return MovieDetailsState(
        movieDetailsApi: movieDetailsApi ?? this.movieDetailsApi,
        similarMoviesApi: similarMoviesApi ?? this.similarMoviesApi
    );
  }
}
