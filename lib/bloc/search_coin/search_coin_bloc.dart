import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_crypto/bloc/search_coin/search_coin_event.dart';
import 'package:vn_crypto/bloc/search_coin/search_coin_state.dart';
import 'package:vn_crypto/data/model/symbol.dart';

class SearchCoinBloc extends Bloc<SearchCoinEvent, SearchCoinState> {
  SearchCoinBloc(SearchCoinState initialState) : super(initialState) {
    on<SearchSymbol>((event, _) => _onSearchSymbol(event));
  }

  void _onSearchSymbol(SearchCoinEvent event) {
    String text = (event as SearchSymbol).text;
    List<Symbol> symbols = event.symbols;
    List<Symbol> result = <Symbol>[];
    for (Symbol symbol in symbols) {
      if (symbol.name.toLowerCase().contains(text.toLowerCase())) result.add(symbol);
    }
    emit(SearchCoinSuccess(result));
  }
}
