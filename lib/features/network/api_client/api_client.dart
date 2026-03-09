import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/constants/app_constants.dart';
import 'package:movies/features/navigation/data/models/movies_response.dart';
import 'package:retrofit/retrofit.dart';
part 'api_client.g.dart';

@singleton
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  // @GET('v2/top-headlines/sources')
  // Future<SourcesResponse> loadNewsSource(
  //     @Query("category")String category,@Query("apiKey")String apiKey
  //     );
  @GET(AppConstants.movieListEndpoint)
  Future<MoviesResponse> loadMovies(
    @Query("limit") int? limit, // e.g. 20, 30, 50
    @Query("page") int? page, // starts at 1
    @Query("genre") String? genre, // "Action", "Sci-Fi", etc. (or null = all)
    @Query("query_term") String? queryTerm, // search keyword
    @Query("sort_by") String? sortBy, // "rating", "year", "seeds", etc.
    @Query("order_by") String? orderBy, // "desc" or "asc"
    @Query("minimum_rating") int? minimumRating, // 0-9
  );
}
