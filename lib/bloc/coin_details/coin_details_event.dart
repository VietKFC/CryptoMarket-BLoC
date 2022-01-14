import 'package:equatable/equatable.dart';

abstract class CoinDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CoinDetailsLoaded extends CoinDetailsEvent {
  final String coinId;

  CoinDetailsLoaded(this.coinId);
}
