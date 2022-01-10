import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_crypto/bloc/home/home_event.dart';
import 'package:vn_crypto/bloc/home/home_state.dart';
import 'package:vn_crypto/data/model/item_coin.dart';
import 'package:vn_crypto/data/model/item_trending_coin.dart';
import 'package:vn_crypto/data/repository/coins_repository.dart';
import 'package:vn_crypto/ultils/Constant.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ListCoinRepository listCoinRepository;
  String currency = "usd";

  HomeBloc({required this.listCoinRepository}) : super(HomeStateInitialized()) {
    on<HomeLoaded>((event, emit) => _onGetCoins());
  }

  void _onGetCoins() async {
    emit(HomeLoading());
    List<ItemCoin> coins = await listCoinRepository.getCoins(currency);
    List<ItemTrendingCoin> trendingCoins =
        await listCoinRepository.getTrendingCoins();
    if (coins.isEmpty) {
      emit(HomeLoadFailed(AppStrings.errorLoadDataFailed));
    } else {
      emit(HomeLoadSuccess(coins: coins, trendingCoins: trendingCoins));
    }
  }
}
