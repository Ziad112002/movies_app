// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/movie_details/data/mappers/movie_details_mapper.dart'
    as _i915;
import '../../features/movie_details/data/repositories/data_sources/movie_details_data_source/movie_details_data_source.dart'
    as _i512;
import '../../features/movie_details/data/repositories/data_sources/movie_details_data_source/movie_details_data_source_impl.dart'
    as _i212;
import '../../features/movie_details/data/repositories/data_sources/similar_movies_data_source/similar_movies_data_source.dart'
    as _i721;
import '../../features/movie_details/data/repositories/data_sources/similar_movies_data_source/similar_movies_data_source_impl.dart'
    as _i819;
import '../../features/movie_details/data/repositories/movie_details_repository_impl.dart'
    as _i541;
import '../../features/movie_details/data/repositories/similar_movies_repository_impl.dart'
    as _i920;
import '../../features/movie_details/domain/models/movie_details.dart' as _i819;
import '../../features/movie_details/domain/repository/movie_details_repository.dart'
    as _i431;
import '../../features/movie_details/domain/repository/similar_movies_repository.dart'
    as _i218;
import '../../features/movie_details/domain/use_cases/movie_details_use_case.dart'
    as _i1057;
import '../../features/movie_details/domain/use_cases/similar_movies_use_case.dart'
    as _i953;
import '../../features/movie_details/ui/screens/cubit/movie_details_cubit.dart'
    as _i865;
import '../../features/movie_details/ui/screens/cubit/movie_details_state.dart'
    as _i469;
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
    gh.factory<_i361.Dio>(() => getItModule.getDio());
    gh.factory<_i915.MovieDetailsMapper>(() => _i915.MovieDetailsMapper());
    gh.factory<_i1001.MoviesMapper>(() => _i1001.MoviesMapper());
    gh.factory<_i469.MovieDetailsState>(
      () => _i469.MovieDetailsState(
        movieDetailsApi: gh<_i275.Resource<_i819.MovieDetails>>(),
        similarMoviesApi: gh<_i275.Resource<List<_i410.Movie>>>(),
      ),
    );
    gh.singleton<_i652.ApiClient>(() => _i652.ApiClient(gh<_i361.Dio>()));
    gh.factory<_i702.MoviesState>(
      () => _i702.MoviesState(gh<_i275.Resource<List<_i410.Movie>>>()),
    );
    gh.factory<_i512.MovieDetailsDataSource>(
      () => _i212.MovieDetailsDataSourceImpl(gh<_i652.ApiClient>()),
    );
    gh.factory<_i91.RemoteMoviesDataSource>(
      () => _i83.RemoteMoviesDataSourceImpl(gh<_i652.ApiClient>()),
    );
    gh.factory<_i721.SimilarMoviesDataSource>(
      () => _i819.SimilarMoviesDataSourceImpl(gh<_i652.ApiClient>()),
    );
    gh.factory<_i27.MoviesRepository>(
      () => _i197.MoviesRepositoryImpl(
        gh<_i895.Connectivity>(),
        gh<_i91.RemoteMoviesDataSource>(),
        gh<_i1001.MoviesMapper>(),
      ),
    );
    gh.factory<_i218.SimilarMoviesRepository>(
      () => _i920.SimilarMoviesRepositoryImpl(
        gh<_i895.Connectivity>(),
        gh<_i1001.MoviesMapper>(),
        gh<_i721.SimilarMoviesDataSource>(),
      ),
    );
    gh.factory<_i431.MovieDetailsRepository>(
      () => _i541.MovieDetailsRepositoryImpl(
        gh<_i512.MovieDetailsDataSource>(),
        gh<_i895.Connectivity>(),
        gh<_i915.MovieDetailsMapper>(),
      ),
    );
    gh.factory<_i729.MoviesUseCase>(
      () => _i729.MoviesUseCase(gh<_i27.MoviesRepository>()),
    );
    gh.factory<_i953.SimilarMoviesUseCase>(
      () => _i953.SimilarMoviesUseCase(gh<_i218.SimilarMoviesRepository>()),
    );
    gh.factory<_i1057.MovieDetailsUseCase>(
      () => _i1057.MovieDetailsUseCase(gh<_i431.MovieDetailsRepository>()),
    );
    gh.factory<_i865.MovieDetailsCubit>(
      () => _i865.MovieDetailsCubit(
        gh<_i1057.MovieDetailsUseCase>(),
        gh<_i953.SimilarMoviesUseCase>(),
      ),
    );
    gh.factory<_i448.MoviesCubit>(
      () => _i448.MoviesCubit(gh<_i729.MoviesUseCase>()),
    );
    return this;
  }
}

class _$GetItModule extends _i1015.GetItModule {}
