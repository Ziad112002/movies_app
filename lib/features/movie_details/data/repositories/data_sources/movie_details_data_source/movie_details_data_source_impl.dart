import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/api_result.dart';
import 'package:movies/core/utils/app_errors.dart';
import 'package:movies/features/movie_details/data/models/movie_details_response.dart';
import 'package:movies/features/movie_details/data/repositories/data_sources/models/stored_movie_model.dart';
import 'package:movies/features/network/api_client/api_client.dart';

import '../../../../../navigation/data/models/movies_response.dart';
import '../../../../../navigation/data/models/remote_movie.dart';
import 'movie_details_data_source.dart';
@Injectable(as: MovieDetailsDataSource)
class MovieDetailsDataSourceImpl extends MovieDetailsDataSource  {
  final ApiClient _apiClient;
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;
  MovieDetailsDataSourceImpl(this._apiClient,this._firestore,this._firebaseAuth);
  @override
  Future<ApiResult<RemoteMovieDetails>> loadMovieDetails(int id)async{
    try {
      var movieDetailsResponse=await _apiClient.loadMovieDetails(id);
      RemoteMovieDetails? remoteMovieDetails=movieDetailsResponse.data!.movie;
      return SuccessApiResult(remoteMovieDetails);
    } on Exception catch (e) {
      return ErrorApiResult(UnKnownErrors(errorMessage: e.toString()));
    }
  }
  @override
  Future<ApiResult<List<RemoteMovie>>>loadSimilarMovies(int id)async {
    try {
      MoviesResponse moviesResponse = await _apiClient.loadSimilarMovies(id);
      List<RemoteMovie> movies = moviesResponse.data.movies;
      return SuccessApiResult(movies);
    } on Exception catch (e) {
      return ErrorApiResult(UnKnownErrors(errorMessage: e.toString()));
    }
  }

  @override
  Future<ApiResult<void>> createMovieInFireStore(StoredMovieModel movie,String collectionName)async {
    try {
      final firebaseUser= _firebaseAuth.currentUser;
      CollectionReference reference= _firestore.collection("users").doc(firebaseUser!.uid).collection(collectionName);
      DocumentReference document=reference.doc();
      movie.id=document.id ;
      await document.set(movie.toJson());
      return SuccessApiResult(null);
    } on FirebaseException catch (e) {
     return ErrorApiResult(UnKnownErrors(errorMessage: e.message??"error"));
    }
  }
  @override
  Future<ApiResult<bool>>checkMovieExists(int movieID,String collectionName)async {
    try {
      final firebaseUser= _firebaseAuth.currentUser;
      QuerySnapshot reference=await _firestore.collection("users").doc(firebaseUser!.uid).collection(collectionName).where("movie_id",isEqualTo: movieID).limit(1).get();
      final result=reference.docs.isNotEmpty;
      return SuccessApiResult(result);
    } on FirebaseException catch (e) {
     return ErrorApiResult(UnKnownErrors(errorMessage: e.message!));
    }
  }

}