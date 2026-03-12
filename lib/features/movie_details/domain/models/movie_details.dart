import 'package:movies/features/movie_details/domain/models/cast.dart';

class MovieDetails {
  final int id;
  final String watchUrl;
  final String title;
  final int year;
  final double rating;
  final int watchCount;
  final int likes;
  final List<String> genres;
  final String trailerCode;
  final String coverImage;
  final String screenshot1;
  final String screenshot2;
  final String screenshot3;
  final List<Cast>cast;
  final String desc;
MovieDetails(this.id,this.screenshot1,this.screenshot2,this.screenshot3,this.coverImage,this.watchUrl,this.title,this.year,this.rating,this.watchCount,this.likes,this.genres,this.desc,this.cast,this.trailerCode);
}