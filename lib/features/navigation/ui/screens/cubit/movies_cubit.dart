import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/resource.dart';
import 'package:movies/features/navigation/domain/use_case/movies_use_case.dart';
import 'package:movies/features/navigation/ui/screens/cubit/movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@injectable
class MoviesCubit extends Cubit<MoviesState>{
  final MoviesUseCase _moviesUseCase;
  MoviesCubit(this._moviesUseCase):super(MoviesState(Resource.initial()));
  Future<void>loadMovies()async{
    emit(MoviesState(Resource.loading()));
    var result=await _moviesUseCase();
    if(result.isSuccess){
      emit(MoviesState(Resource.success(result.getData())));
    }else{
      emit(MoviesState(Resource.error(result.error!.errorMessage)));
    }
  }

}