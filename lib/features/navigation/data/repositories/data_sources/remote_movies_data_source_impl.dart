import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/api_result.dart';
import 'package:movies/core/utils/app_errors.dart';
import 'package:movies/features/movie_details/data/repositories/data_sources/models/stored_movie_model.dart';
import 'package:movies/features/network/api_client/api_client.dart';
import 'package:movies/features/navigation/data/models/movies_response.dart';
import 'package:movies/features/navigation/data/models/remote_movie.dart';

import 'remote_movies_data_source.dart';

@Injectable(as: RemoteMoviesDataSource)
class RemoteMoviesDataSourceImpl extends RemoteMoviesDataSource {
  final ApiClient _apiClient;
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;
  RemoteMoviesDataSourceImpl(this._apiClient,this._firestore,this._firebaseAuth);
  @override
  Future<ApiResult<List<RemoteMovie>>> loadMovies(
    int? limit,
    int? page,
    String? genre,
    String? queryTerm,
    String? sortBy,
    String? orderBy,
    int? minimumRating,
  ) async {
    try {
      MoviesResponse moviesResponse = await _apiClient.loadMovies(limit,page,genre,queryTerm,sortBy,orderBy,minimumRating);
      List<RemoteMovie> movies = moviesResponse.data.movies;
      return SuccessApiResult(movies);
    } on Exception catch (e) {
      return ErrorApiResult(UnKnownErrors(errorMessage: e.toString()));
    }
  }

  @override
  Future<ApiResult<List<StoredMovieModel>>> loadMoviesFromFirestore(String collectionName) async{
    try {
      final currentUser=_firebaseAuth.currentUser;
      CollectionReference reference=_firestore.collection("users").doc(currentUser!.uid).collection(collectionName);
      QuerySnapshot snapshots=await reference.get();
      List<StoredMovieModel> movies=snapshots.docs.map((doc){
        Map<String,dynamic>json=doc.data() as Map<String,dynamic>;
        return StoredMovieModel.fromJson(json);
      }).toList();
      return SuccessApiResult(movies);
    } on FirebaseException catch (e) {
     return ErrorApiResult(UnKnownErrors(errorMessage: e.message!));
    }

  }
}
