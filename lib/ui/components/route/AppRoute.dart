import 'package:flutter/material.dart';
import 'package:vn_crypto/data/model/item_coin.dart';
import 'package:vn_crypto/ui/components/profile/profile_screen.dart';
import 'package:vn_crypto/ui/convertcoin/convert_coin.dart';
import 'package:vn_crypto/ui/home/home_page.dart';
import 'package:vn_crypto/ui/investmanagement/add_invest_page.dart';
import 'package:vn_crypto/ui/screen/CoinDetailsScreen.dart';
import 'package:vn_crypto/ui/screen/FollowingCoinsScreen.dart';

Route appRoutes(RouteSettings settings) {
  switch (settings.name) {
    case ConvertCoinPage.PAGE_ROUTE_NAME:
      List<ItemCoin> coins = settings.arguments as List<ItemCoin>;
      return MaterialPageRoute(builder: (_) => ConvertCoinPage(coins: coins));
    case CoinDetailsScreen.PAGE_ROUTE_NAME:
      ItemCoin itemCoin = settings.arguments as ItemCoin;
      return MaterialPageRoute(builder: (_) => CoinDetailsScreen(coin: itemCoin));
    case FollowingCoinsScreen.PAGE_ROUTE_NAME:
      return MaterialPageRoute(builder: (_) => const FollowingCoinsScreen());
    case AddInvestPage.PAGE_ROUTE_NAME:
      List<Object> arguments = settings.arguments as List<Object>;
      ItemCoin itemCoin = arguments.first as ItemCoin;
      Function addInvestCallback = arguments[1] as Function;
      return MaterialPageRoute(builder: (_) => AddInvestPage(itemCoin: itemCoin, addInvestCallback: addInvestCallback));
    case ProfileScreen.PAGE_ROUTE_NAME:
      return MaterialPageRoute(builder: (_) => const ProfileScreen());
    default:
      return MaterialPageRoute(builder: (_) => const HomePage());
  }
}
