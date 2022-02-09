import 'package:equatable/equatable.dart';
import 'package:vn_crypto/data/model/item_coin.dart';

abstract class InvestManagementEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InvestManagementLoaded extends InvestManagementEvent {}

class InvestManagementSaveCoin extends InvestManagementEvent {
  final ItemCoin itemCoin;

  InvestManagementSaveCoin(this.itemCoin);
}

class InvestManagementDeleteCoin extends InvestManagementEvent {
  final ItemCoin itemCoin;

  InvestManagementDeleteCoin(this.itemCoin);
}

class InvestManagementCoinMarketLoaded extends InvestManagementEvent {
  final String currency;

  InvestManagementCoinMarketLoaded(this.currency);
}
