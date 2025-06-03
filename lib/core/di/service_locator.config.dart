// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:lost_and_found_app/core/networke/dio_helper.dart' as _i522;
import 'package:lost_and_found_app/futures/home_store/data/data_source/home_store_data_source.dart'
    as _i647;
import 'package:lost_and_found_app/futures/home_store/data/repository/home_store_repo_imp.dart'
    as _i795;
import 'package:lost_and_found_app/futures/home_store/domain/repository/home_store_repo.dart'
    as _i774;
import 'package:lost_and_found_app/futures/home_store/presentation/cubits/home_store_cubit.dart'
    as _i1036;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i522.BaseDioHelper>(() => _i522.DioHelper());
    gh.lazySingleton<_i647.HomeStoreDataSource>(
      () => _i647.HomeStoreDataSourceImpl(gh<_i522.BaseDioHelper>()),
    );
    gh.factory<_i774.HomeStoreRepo>(
      () => _i795.HomeStoreRepoImp(gh<_i647.HomeStoreDataSource>()),
    );
    gh.lazySingleton<_i1036.HomeStoreCubit>(
      () => _i1036.HomeStoreCubit(gh<_i774.HomeStoreRepo>()),
    );
    return this;
  }
}
