import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/resource.dart';
import 'package:movies/features/movie_details/data/repositories/data_sources/models/stored_movie_model.dart';
import 'package:movies/features/movie_details/domain/use_cases/check_movie_exists_use_case.dart';
import 'package:movies/features/movie_details/domain/use_cases/toggle_movie_in_firestore_use_case.dart';
import 'package:movies/features/movie_details/domain/use_cases/movie_details_use_case.dart';
import 'package:movies/features/movie_details/domain/use_cases/similar_movies_use_case.dart';
import 'package:movies/features/movie_details/ui/screens/cubit/movie_details_state.dart';

@injectable
class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MovieDetailsUseCase _movieDetailsUseCase;
  final SimilarMoviesUseCase _similarMoviesUseCase;
  final ToggleMovieInFirestoreUseCase _toggleMovieInFirestoreUseCase;
  final CheckMovieExistsUseCase _checkMovieExistsUseCase;
  MovieDetailsCubit(
    this._movieDetailsUseCase,
    this._similarMoviesUseCase,
    this._toggleMovieInFirestoreUseCase,
    this._checkMovieExistsUseCase,
  ) : super(
        MovieDetailsState(
          movieDetailsApi: Resource.initial(),
          similarMoviesApi: Resource.initial(),
          toggleMovieServer: Resource.initial(),
          checkMovieServer: Resource.initial(),
        ),
      );
  Future<void> loadMovieDetails(int id) async {
    emit(state.copyWith(movieDetailsApi: Resource.loading()));
    var result = await _movieDetailsUseCase(id);
    if (result.isSuccess) {
      emit(state.copyWith(movieDetailsApi: Resource.success(result.getData())));
    } else {
      emit(
        state.copyWith(
          movieDetailsApi: Resource.error(result.error!.errorMessage),
        ),
      );
    }
  }

  Future<void> loadSimilarMovies(int id) async {
    emit(state.copyWith(similarMoviesApi: Resource.loading()));
    var result = await _similarMoviesUseCase(id);
    if (result.isSuccess) {
      emit(
        state.copyWith(similarMoviesApi: Resource.success(result.getData())),
      );
    } else {
      emit(
        state.copyWith(
          similarMoviesApi: Resource.error(result.error!.errorMessage),
        ),
      );
    }
  }

  Future<void> toggleMovieInFirestore(
    StoredMovieModel movie,
    String collectionName,
      bool isExist,
  ) async {
    emit(state.copyWith(toggleMovieServer: Resource.loading()));
    var result = await _toggleMovieInFirestoreUseCase(movie, collectionName,isExist);
    if (result.isSuccess) {
      emit(
        state.copyWith(toggleMovieServer: Resource.success(null)),
      );
    } else {
      emit(
        state.copyWith(
          toggleMovieServer: Resource.error(result.error!.errorMessage),
        ),
      );
    }
  }

  Future<void> checkMovieExists(int movieId, String collectionName) async {
    emit(state.copyWith(checkMovieServer: Resource.loading()));
    var result = await _checkMovieExistsUseCase(movieId, collectionName);
    if (result.isSuccess) {
      emit(
        state.copyWith(checkMovieServer: Resource.success(result.getData())),
      );
    } else {
      emit(
        state.copyWith(
          toggleMovieServer: Resource.error(result.error!.errorMessage),
        ),
      );
    }
  }
}
