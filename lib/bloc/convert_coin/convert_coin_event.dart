import 'package:equatable/equatable.dart';

abstract class ConvertCoinEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class SupportedCoinsLoaded extends ConvertCoinEvent {
  SupportedCoinsLoaded();
}

class ConvertCoinLoaded extends ConvertCoinEvent {
  final String id;
  final String currency;

  ConvertCoinLoaded(this.id, this.currency);
}
