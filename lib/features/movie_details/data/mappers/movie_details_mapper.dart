import 'package:injectable/injectable.dart';
import 'package:movies/features/movie_details/data/models/movie_details_response.dart';
import 'package:movies/features/movie_details/domain/models/cast.dart';
import 'package:movies/features/movie_details/domain/models/movie_details.dart';

@injectable
class MovieDetailsMapper {
  Cast toCast(RemoteCast remoteCast) => Cast(
    remoteCast.urlSmallImage ?? "",
    remoteCast.characterName ?? "Unknown",
    remoteCast.name ?? "unKnown",
  );
  List<Cast> toCasts(List<RemoteCast> remoteCasts) =>
      remoteCasts.map((remoteCast) => toCast(remoteCast)).toList();
  MovieDetails toMovieDetails(RemoteMovieDetails remoteMovieDetails) =>
      MovieDetails(
        remoteMovieDetails.id ?? 0,
        remoteMovieDetails.largeScreenshotImage1??"",
        remoteMovieDetails.largeScreenshotImage2??"",
        remoteMovieDetails.largeScreenshotImage3??"",
        remoteMovieDetails.largeCoverImage??"",
        remoteMovieDetails.url ?? "",
        remoteMovieDetails.title ?? "",
        remoteMovieDetails.year ?? 0,
        remoteMovieDetails.rating ?? 0,
        remoteMovieDetails.runtime ?? 0,
        remoteMovieDetails.likeCount ?? 0,
        remoteMovieDetails.genres ?? [],
        remoteMovieDetails.descriptionFull ?? "",
        MovieDetailsMapper().toCasts(remoteMovieDetails.cast ?? []),
        remoteMovieDetails.ytTrailerCode ?? '',
      );
}
