import 'package:dio/dio.dart';
import 'package:vn_crypto/data/model/item_coin.dart';
import 'package:vn_crypto/data/service/url.dart';

class Api {
  Api({
    Dio? dio,
  }) : dio = dio ?? Dio() {
    this.dio.interceptors.add(LogInterceptor());
  }

  final Dio dio;

  Future<List<ItemCoin>> getCoins(String currency) async {
    final response = await dio
        .get(Url.GET_COINS_URL, queryParameters: {'vs_currency': currency});
    List<ItemCoin> itemCoins = [];
    List<dynamic> itemCoinsReponse = response.data as List;
    for (int i = 0; i < itemCoinsReponse.length; i++) {
      itemCoins.add(ItemCoin.fromJson(itemCoinsReponse[i]));
    }
    return itemCoins;
  }
}
