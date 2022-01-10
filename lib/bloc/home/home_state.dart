import 'package:equatable/equatable.dart';
import 'package:vn_crypto/data/model/item_coin.dart';
import 'package:vn_crypto/data/model/item_trending_coin.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => throw UnimplementedError();
}

class HomeStateInitialized extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoadSuccess extends HomeState {
  final List<ItemCoin> coins;
  final List<ItemTrendingCoin> trendingCoins;

  HomeLoadSuccess({required this.coins, required this.trendingCoins});

  @override
  List<Object> get props => [coins, trendingCoins];
}

class HomeLoadFailed extends HomeState {
  final dynamic error;

  HomeLoadFailed(this.error);

  @override
  List<Object> get props => [error];
}
