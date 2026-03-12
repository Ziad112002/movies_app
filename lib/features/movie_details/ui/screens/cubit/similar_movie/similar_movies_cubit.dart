// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:injectable/injectable.dart';
// import 'package:movies/core/utils/resource.dart';
// import 'package:movies/features/movie_details/domain/use_cases/similar_movies_use_case.dart';
// import 'package:movies/features/movie_details/ui/screens/cubit/similar_movie/similar_movies_state.dart';
//
// @injectable
// class SimilarMoviesCubit extends Cubit<SimilarMoviesState> {
//   final SimilarMoviesUseCase _moviesUseCase;
//   SimilarMoviesCubit(this._moviesUseCase):super(SimilarMoviesState(Resource.initial()));
//   Future<void>loadSimilarMovies(int id)async{
//     emit(SimilarMoviesState(Resource.loading()));
//     var result=await _similarMoviesUseCase(id);
//    if(result.isSuccess){
//      emit(SimilarMoviesState(Resource.success(result.getData())));
//    }else{
//      emit(SimilarMoviesState(Resource.error(result.error!.errorMessage)));
//    }
//   }
//
// errorMessage
// }