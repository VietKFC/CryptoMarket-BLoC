import 'package:dio/dio.dart';

class Api {
  Api({
    Dio? dio,
  }) : dio = dio ?? Dio() {
    this.dio.interceptors.add(LogInterceptor());
  }

  final Dio dio;
}
