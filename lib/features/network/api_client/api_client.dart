import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/constants/app_constants.dart';
import 'package:movies/features/network/models/movies_response.dart';
import 'package:retrofit/retrofit.dart';
part 'api_client.g.dart';
@singleton
@RestApi()
abstract class ApiClient {
  @factoryMethod
factory ApiClient(Dio dio,) = _ApiClient;

// @GET('v2/top-headlines/sources')
// Future<SourcesResponse> loadNewsSource(
//     @Query("category")String category,@Query("apiKey")String apiKey
//     );
  @GET(AppConstants.movieListEndpoint)

Future<MoviesResponse> loadMovies(

    );
}
