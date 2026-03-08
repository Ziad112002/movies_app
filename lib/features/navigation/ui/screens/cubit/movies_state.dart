import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/resource.dart';
import 'package:movies/features/navigation/domain/models/movie.dart';
@injectable
class MoviesState {
  late Resource<List<Movie>>moviesApi;
  MoviesState(this.moviesApi);
  MoviesState.initial(){
    moviesApi=Resource.initial();
  }
}