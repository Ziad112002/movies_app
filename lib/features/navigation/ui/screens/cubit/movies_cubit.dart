import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/resource.dart';
import 'package:movies/features/navigation/domain/use_case/firestore_movies_use_case.dart';
import 'package:movies/features/navigation/domain/use_case/movies_use_case.dart';
import 'package:movies/features/navigation/ui/screens/cubit/movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@injectable
class MoviesCubit extends Cubit<MoviesState>{
  final MoviesUseCase _moviesUseCase;
  final FirestoreMoviesUseCase _firestoreMoviesUseCase;
  MoviesCubit(this._moviesUseCase,this._firestoreMoviesUseCase):super(MoviesState(moviesApi: Resource.initial(),moviesServer: Resource.initial()));
  Future<void>loadMovies(  int? limit,
      int? page,
      String? genre,
      String? queryTerm,
      String? sortBy,
      String? orderBy,
      int? minimumRating,)async{
    emit(state.copyWith(moviesApi: Resource.loading()));
    final result=await _moviesUseCase(limit,page,genre,queryTerm,sortBy,orderBy,minimumRating);
    if(result.isSuccess){
      emit(state.copyWith(moviesApi: Resource.success(result.getData())));
    }else{
      emit(state.copyWith(moviesApi: Resource.error(result.error!.errorMessage)));
    }
  }
  Future<void> loadFirestoreMovies(String collectionName)async{
    emit(state.copyWith(moviesApi: Resource.loading()));
    final result=await _firestoreMoviesUseCase(collectionName);
    if(result.isSuccess){
      emit(state.copyWith(moviesServer: Resource.success(result.getData())));
    }else{
      emit(state.copyWith(moviesServer: Resource.error(result.error!.errorMessage)));
    }
  }

}