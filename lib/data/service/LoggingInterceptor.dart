import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    print("Information ---->\n" +
        "METHOD: " +
        options.method.toUpperCase() +
        "\n" +
        "URL: " +
        options.baseUrl +
        options.path);
    if (options.queryParameters != null) {
      print("Query Parameters: ");
      options.queryParameters.forEach((key, value) {
        print("$key: $value");
      });
    }

    if (options.data != null) {
      print("BODY: " + options.data);
    }
    print("END ---->");
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);

    if (response.data != null && response.data is List<dynamic>) {
      print("RESPONSE BODY: \n");
      for (var element in (response.data as List<dynamic>)) {
        print(element);
      }
    }
  }
}
