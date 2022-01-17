import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:vn_crypto/data/repository/categories_repository.dart';
import 'package:vn_crypto/data/repository/coins_repository.dart';
import 'package:vn_crypto/data/repository/convert_coin_repository.dart';
import 'package:vn_crypto/data/service/api.dart';

final getIt = GetIt.instance;

configureInjection() async {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerLazySingleton<Api>(() => Api(dio: getIt<Dio>()));

  getIt.registerLazySingleton<CoinRepository>(
      () => CoinRepository(api: getIt.get<Api>()));

  getIt.registerLazySingleton<CategoryRepository>(
      () => CategoryRepository(api: getIt.get<Api>()));
  getIt.registerLazySingleton<ConvertCoinRepository>(
      () => ConvertCoinRepository(api: getIt.get<Api>()));
}
