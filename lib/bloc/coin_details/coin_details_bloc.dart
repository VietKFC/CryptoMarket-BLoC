import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_chart/interactive_chart.dart';
import 'package:vn_crypto/bloc/coin_details/coin_details_event.dart';
import 'package:vn_crypto/bloc/coin_details/coin_details_state.dart';
import 'package:vn_crypto/data/model/coin_detail.dart';
import 'package:vn_crypto/data/repository/coins_repository.dart';
import 'package:vn_crypto/ultils/Constant.dart';

class CoinDetailsBloc extends Bloc<CoinDetailsEvent, CoinDetailsState> {
  final CoinRepository coinRepository;

  CoinDetailsBloc({required this.coinRepository})
      : super(CoinDetailsStateInitialized()) {
    on<CoinDetailsLoaded>((event, emit) => _onGetCoin(event, emit));
  }

  void _onGetCoin(var event, var emit) async {
    String coinId = (event as CoinDetailsLoaded).coinId;
    emit(CoinDetailsLoading());
    CoinDetails coin =
        await coinRepository.getCoin(coinId);
    List<CandleData> candleDatas = await coinRepository.getCoinOhlc(coinId, AppStrings.textCurrency, Constant.defaultDays);
    if (coin == null) {
      emit(CoinDetailsLoadFailed(AppStrings.errorLoadDataFailed));
    } else {
      emit(CoinDetailsLoadSuccess(coin: coin, candleDatas: candleDatas));
    }
  }
}
