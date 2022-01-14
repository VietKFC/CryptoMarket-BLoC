import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_crypto/bloc/list_coin/list_coin_event.dart';
import 'package:vn_crypto/bloc/list_coin/list_coin_state.dart';
import 'package:vn_crypto/data/model/item_coin.dart';
import 'package:vn_crypto/data/repository/coins_repository.dart';
import 'package:vn_crypto/ultils/Constant.dart';

class ListCoinBloc extends Bloc<ListCoinEvent, ListCoinState> {
  final CoinRepository listCoinRepository;

  ListCoinBloc({required this.listCoinRepository})
      : super(ListCoinStateInitialized()) {
    on<ListCoinLoaded>((event, emit) => _onGetCoins(emit));
  }

  void _onGetCoins(var emit) async {
    emit(ListCoinLoading());
    List<ItemCoin> coins =
        await listCoinRepository.getCoins(AppStrings.textCurrency);
    if (coins.isEmpty) {
      emit(ListCoinLoadFailed(AppStrings.errorLoadDataFailed));
    } else {
      emit(ListCoinLoadSuccess(coins: coins));
    }
  }
}
