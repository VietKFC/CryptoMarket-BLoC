import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:vn_crypto/data/service/api.dart';

final getIt = GetIt.instance;

configureInjection() {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerLazySingleton<Api>(() => Api(dio: getIt<Dio>()));
}
