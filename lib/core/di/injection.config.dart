// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/movies/data/services/movies_service.dart' as _i955;
import '../../features/movies/presentation/cubit/movie_details/movie_details_cubit.dart'
    as _i334;
import '../../features/movies/presentation/cubit/movies/movies_cubit.dart'
    as _i405;
import 'injection.dart' as _i464;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio());
    gh.lazySingleton<_i955.MoviesService>(
      () => _i955.MoviesServiceImpl(gh<_i361.Dio>()),
    );
    gh.factory<_i405.MoviesCubit>(
      () => _i405.MoviesCubit(services: gh<_i955.MoviesService>()),
    );
    gh.factory<_i334.MovieDetailsCubit>(
      () => _i334.MovieDetailsCubit(service: gh<_i955.MoviesService>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i464.RegisterModule {}
