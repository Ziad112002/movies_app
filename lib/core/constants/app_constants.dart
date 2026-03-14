import 'dart:ui';

import 'package:movies/core/utils/app_assets.dart';
import 'package:movies/features/splash_onboarding/model/onboarding_model.dart';

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
  static List<OnboardingModel> onboardingItems = [
    OnboardingModel(
      image: AppAssets.onboardingMoviesPosters,
      title: "Find Your Next Favorite Movie Here",
      description:
          "Get access to a huge library of movies to suit all tastes. You will surely like it.",
      color: Color(0xff1E1E1E),
      transparentColor: Color(0x001E1E1E),
    ),
    OnboardingModel(
      image: AppAssets.onboardingAvengers,
      title: "Discover Movies",
      description:
          "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
      color: Color(0xff084250),
      transparentColor: Color(0x00084250),
    ),
    OnboardingModel(
      image: AppAssets.onboardingOppenheimer,
      title: "Explore All Genres",
      description:
          "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
      color: Color(0xff85210E),
      transparentColor: Color(0x0085210E),
    ),
    OnboardingModel(
      image: AppAssets.onboardingBadBoys,
      title: "Create Watch lists",
      description:
          "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
      color: Color(0xff4C2471),
      transparentColor: Color(0x004C2471),
    ),
    OnboardingModel(
      image: AppAssets.onboardingStrange,
      title: "Rate, Review, and Learn",
      description:
          "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
      color: Color(0xff601321),
      transparentColor: Color(0x00601321),
    ),
    OnboardingModel(
      image: AppAssets.onboarding1917,
      title: "Start Watching Now",
      description:"",
      color: Color(0xff2A2C30),
      transparentColor: Color(0x002A2C30),
    ),
  ];
}
