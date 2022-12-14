// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:vn_crypto/data/repository/categories_repository.dart' as _i5;
import 'package:vn_crypto/data/repository/coins_repository.dart' as _i6;
import 'package:vn_crypto/data/repository/convert_coin_repository.dart' as _i8;
import 'package:vn_crypto/data/repository/follow_repository.dart' as _i9;
import 'package:vn_crypto/data/repository/InvestRepository.dart' as _i10;
import 'package:vn_crypto/data/service/api.dart' as _i7;
import 'package:vn_crypto/data/service/api_service.dart' as _i3;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.Api>(() => _i3.Api(dio: gh<_i4.Dio>()));
    gh.lazySingleton<_i5.CategoryRepository>(
        () => _i5.CategoryRepository(api: gh<_i3.Api>()));
    gh.lazySingleton<_i6.CoinRepository>(
        () => _i6.CoinRepository(api: gh<_i7.Api>()));
    gh.lazySingleton<_i8.ConvertCoinRepository>(
        () => _i8.ConvertCoinRepository(api: gh<_i3.Api>()));
    gh.lazySingleton<_i9.FollowRepository>(() => _i9.FollowRepository());
    gh.lazySingleton<_i10.InvestRepository>(
        () => _i10.InvestRepository(api: gh<_i7.Api>()));
    return this;
  }
}
