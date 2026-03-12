import 'package:injectable/injectable.dart';
import 'package:movies/features/navigation/data/models/remote_movie.dart';
import 'package:movies/features/navigation/domain/models/movie.dart';
@injectable
class MoviesMapper {
  Movie getMovie(RemoteMovie movie){
    return Movie(movie.rating, movie.mediumCoverImage??"",movie.id);
  }
  List<Movie> getMovies(List<RemoteMovie> movies){
    return movies.map((movie)=>getMovie(movie)).toList();
  }
}