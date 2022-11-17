import 'package:equatable/equatable.dart';
import 'package:vn_crypto/data/model/symbol.dart';

abstract class SearchCoinEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class SearchSymbol extends SearchCoinEvent {
  final String text;
  final List<Symbol> symbols;

  SearchSymbol(this.text, this.symbols);
}
