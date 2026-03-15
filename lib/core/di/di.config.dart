// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/mapper/auth_mapper.dart' as _i496;
import '../../features/auth/data/repositories/auth_repos_impl.dart' as _i657;
import '../../features/auth/data/repositories/remote_data_source/auth_remote_data_source.dart'
    as _i876;
import '../../features/auth/data/repositories/remote_data_source/auth_remote_data_source_impl.dart'
    as _i259;
import '../../features/auth/domain/repository/auth_repos.dart' as _i563;
import '../../features/auth/domain/use_cases/current_user_use_case.dart'
    as _i410;
import '../../features/auth/domain/use_cases/delete_account_use_case.dart'
    as _i353;
import '../../features/auth/domain/use_cases/forgot_pass_use_case.dart' as _i68;
import '../../features/auth/domain/use_cases/login_use_case.dart' as _i1038;
import '../../features/auth/domain/use_cases/login_with_google_use_case.dart'
    as _i490;
import '../../features/auth/domain/use_cases/logout_use_case.dart' as _i698;
import '../../features/auth/domain/use_cases/sign_up_use_case.dart' as _i179;
import '../../features/auth/domain/use_cases/update_account_use_case.dart'
    as _i44;
import '../../features/auth/ui/screens/cubit/auth_cubit.dart' as _i263;
import '../../features/movie_details/data/mappers/movie_details_mapper.dart'
    as _i915;
import '../../features/movie_details/data/repositories/data_sources/models/stored_movie_model.dart'
    as _i667;
import '../../features/movie_details/data/repositories/data_sources/movie_details_data_source/movie_details_data_source.dart'
    as _i512;
import '../../features/movie_details/data/repositories/data_sources/movie_details_data_source/movie_details_data_source_impl.dart'
    as _i212;
import '../../features/movie_details/data/repositories/movie_details_repository_impl.dart'
    as _i541;
import '../../features/movie_details/domain/models/movie_details.dart' as _i819;
import '../../features/movie_details/domain/repository/movie_details_repository.dart'
    as _i431;
import '../../features/movie_details/domain/use_cases/check_movie_exists_use_case.dart'
    as _i735;
import '../../features/movie_details/domain/use_cases/create_movie_in_fire_store_use_case.dart'
    as _i471;
import '../../features/movie_details/domain/use_cases/movie_details_use_case.dart'
    as _i1057;
import '../../features/movie_details/domain/use_cases/similar_movies_use_case.dart'
    as _i953;
import '../../features/movie_details/ui/screens/cubit/movie_details_cubit.dart'
    as _i384;
import '../../features/movie_details/ui/screens/cubit/movie_details_state.dart'
    as _i575;
import '../../features/navigation/data/mapper/movies_mapper.dart' as _i1001;
import '../../features/navigation/data/repositories/data_sources/remote_movies_data_source.dart'
    as _i91;
import '../../features/navigation/data/repositories/data_sources/remote_movies_data_source_impl.dart'
    as _i83;
import '../../features/navigation/data/repositories/movies_repository_impl.dart'
    as _i197;
import '../../features/navigation/domain/models/movie.dart' as _i410;
import '../../features/navigation/domain/repository/movies_repository.dart'
    as _i27;
import '../../features/navigation/domain/use_case/firestore_movies_use_case.dart'
    as _i540;
import '../../features/navigation/domain/use_case/movies_use_case.dart'
    as _i729;
import '../../features/navigation/ui/screens/cubit/movies_cubit.dart' as _i448;
import '../../features/navigation/ui/screens/cubit/movies_state.dart' as _i702;
import '../../features/network/api_client/api_client.dart' as _i652;
import '../utils/resource.dart' as _i275;
import 'get_it_module.dart' as _i1015;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final getItModule = _$GetItModule();
    gh.factory<_i895.Connectivity>(() => getItModule.getConnectivity());
    gh.factory<_i496.AuthMapper>(() => _i496.AuthMapper());
    gh.factory<_i915.MovieDetailsMapper>(() => _i915.MovieDetailsMapper());
    gh.factory<_i1001.MoviesMapper>(() => _i1001.MoviesMapper());
    gh.singleton<_i361.Dio>(() => getItModule.getDio());
    gh.singleton<_i59.FirebaseAuth>(() => getItModule.getFirebaseAuth());
    gh.singleton<_i974.FirebaseFirestore>(() => getItModule.getFirestore());
    gh.factory<_i876.AuthRemoteDataSource>(
      () => _i259.AuthRemoteDataSourceImpl(
        gh<_i59.FirebaseAuth>(),
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.factory<_i575.MovieDetailsState>(
      () => _i575.MovieDetailsState(
        movieDetailsApi: gh<_i275.Resource<_i819.MovieDetails>>(),
        similarMoviesApi: gh<_i275.Resource<List<_i410.Movie>>>(),
        createMovieServer: gh<_i275.Resource<void>>(),
        checkMovieServer: gh<_i275.Resource<bool>>(),
      ),
    );
    gh.singleton<_i652.ApiClient>(() => _i652.ApiClient(gh<_i361.Dio>()));
    gh.factory<_i702.MoviesState>(
      () => _i702.MoviesState(
        moviesApi: gh<_i275.Resource<List<_i410.Movie>>>(),
        moviesServer: gh<_i275.Resource<List<_i667.StoredMovieModel>>>(),
      ),
    );
    gh.factory<_i512.MovieDetailsDataSource>(
      () => _i212.MovieDetailsDataSourceImpl(
        gh<_i652.ApiClient>(),
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.factory<_i91.RemoteMoviesDataSource>(
      () => _i83.RemoteMoviesDataSourceImpl(
        gh<_i652.ApiClient>(),
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.factory<_i563.AuthRepos>(
      () => _i657.AuthReposImpl(
        gh<_i895.Connectivity>(),
        gh<_i496.AuthMapper>(),
        gh<_i876.AuthRemoteDataSource>(),
      ),
    );
    gh.factory<_i27.MoviesRepository>(
      () => _i197.MoviesRepositoryImpl(
        gh<_i895.Connectivity>(),
        gh<_i91.RemoteMoviesDataSource>(),
        gh<_i1001.MoviesMapper>(),
      ),
    );
    gh.factory<_i431.MovieDetailsRepository>(
      () => _i541.MovieDetailsRepositoryImpl(
        gh<_i512.MovieDetailsDataSource>(),
        gh<_i895.Connectivity>(),
        gh<_i915.MovieDetailsMapper>(),
        gh<_i1001.MoviesMapper>(),
      ),
    );
    gh.factory<_i1057.MovieDetailsUseCase>(
      () => _i1057.MovieDetailsUseCase(gh<_i431.MovieDetailsRepository>()),
    );
    gh.factory<_i410.CurrentUserUseCase>(
      () => _i410.CurrentUserUseCase(gh<_i563.AuthRepos>()),
    );
    gh.factory<_i353.DeleteAccountUseCase>(
      () => _i353.DeleteAccountUseCase(gh<_i563.AuthRepos>()),
    );
    gh.factory<_i68.ForgotPassUseCase>(
      () => _i68.ForgotPassUseCase(gh<_i563.AuthRepos>()),
    );
    gh.factory<_i1038.LoginUseCase>(
      () => _i1038.LoginUseCase(gh<_i563.AuthRepos>()),
    );
    gh.factory<_i490.LoginWithGoogleUseCase>(
      () => _i490.LoginWithGoogleUseCase(gh<_i563.AuthRepos>()),
    );
    gh.factory<_i698.LogoutUseCase>(
      () => _i698.LogoutUseCase(gh<_i563.AuthRepos>()),
    );
    gh.factory<_i179.SignUpUseCase>(
      () => _i179.SignUpUseCase(gh<_i563.AuthRepos>()),
    );
    gh.factory<_i44.UpdateAccountUseCase>(
      () => _i44.UpdateAccountUseCase(gh<_i563.AuthRepos>()),
    );
    gh.factory<_i540.FirestoreMoviesUseCase>(
      () => _i540.FirestoreMoviesUseCase(gh<_i27.MoviesRepository>()),
    );
    gh.factory<_i471.CreateMovieInFireStoreUseCase>(
      () => _i471.CreateMovieInFireStoreUseCase(
        gh<_i431.MovieDetailsRepository>(),
      ),
    );
    gh.factory<_i953.SimilarMoviesUseCase>(
      () => _i953.SimilarMoviesUseCase(gh<_i431.MovieDetailsRepository>()),
    );
    gh.factory<_i735.CheckMovieExistsUseCase>(
      () => _i735.CheckMovieExistsUseCase(gh<_i431.MovieDetailsRepository>()),
    );
    gh.factory<_i384.MovieDetailsCubit>(
      () => _i384.MovieDetailsCubit(
        gh<_i1057.MovieDetailsUseCase>(),
        gh<_i953.SimilarMoviesUseCase>(),
        gh<_i471.CreateMovieInFireStoreUseCase>(),
        gh<_i735.CheckMovieExistsUseCase>(),
      ),
    );
    gh.factory<_i729.MoviesUseCase>(
      () => _i729.MoviesUseCase(gh<_i27.MoviesRepository>()),
    );
    gh.factory<_i263.AuthCubit>(
      () => _i263.AuthCubit(
        gh<_i179.SignUpUseCase>(),
        gh<_i1038.LoginUseCase>(),
        gh<_i698.LogoutUseCase>(),
        gh<_i410.CurrentUserUseCase>(),
        gh<_i490.LoginWithGoogleUseCase>(),
        gh<_i68.ForgotPassUseCase>(),
        gh<_i353.DeleteAccountUseCase>(),
        gh<_i44.UpdateAccountUseCase>(),
      ),
    );
    gh.factory<_i448.MoviesCubit>(
      () => _i448.MoviesCubit(
        gh<_i729.MoviesUseCase>(),
        gh<_i540.FirestoreMoviesUseCase>(),
      ),
    );
    return this;
  }
}

class _$GetItModule extends _i1015.GetItModule {}
