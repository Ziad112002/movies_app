import 'package:movies/core/utils/app_assets.dart';

abstract final class AppConstants {
  static const baseUrl = "https://movies-api.accel.li/api/v2/";
  static const movieListEndpoint = "list_movies.json";
  static const movieDetailsEndpoint = "movie_details.json";
  static const similarMovieEndpoint = "movie_suggestions.json";
  static const List<String> allMovieGenres = [
    "Action",
    "Adventure",
    "Animation",
    "Biography",
    "Comedy",
    "Crime",
    "Documentary",
    "Drama",
    "Family",
    "Fantasy",
    "History",
    "Horror",
    "Music",
    "Musical",
    "Mystery",
    "News",
    "Romance",
    "Sci-Fi",
    "Sport",
    "Thriller",
    "War",
    "Western",
  ];
  static const List<String> avatars = [
    AppAssets.gamer1,
    AppAssets.gamer,
    AppAssets.gamer2,
    AppAssets.gamer3,
    AppAssets.gamer4,
    AppAssets.gamer5,
    AppAssets.gamer6,
    AppAssets.gamer7,
    AppAssets.gamer8,
  ];
  static String defaultErrorMessage =
      "Something went wrong, please try again later!";
}
