import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_crypto/bloc/convert_coin/convert_coin_event.dart';
import 'package:vn_crypto/bloc/convert_coin/convert_coin_state.dart';
import 'package:vn_crypto/data/repository/convert_coin_repository.dart';
import 'package:vn_crypto/ultils/Constant.dart';

class ConvertCoinBloc extends Bloc<ConvertCoinEvent, ConvertCoinState> {
  final ConvertCoinRepository convertCoinRepository;
  Color originalCoinColor = AppColors.colorMystic;
  Color convertedCoinColor = Colors.white;

  ConvertCoinBloc({required this.convertCoinRepository})
      : super(ConvertCoinInitialize()) {
    on<ConvertCoinLoaded>((event, _) => _onGetPriceConvertedData(event));
    on<SupportedCoinsLoaded>((event, emit) => _onGetSupportedCurrenciesData());
    on<ChangeColorOfCoinField>((event, emit) => _onChangeCoinFieldColor(event));
  }

  void _onChangeCoinFieldColor(ConvertCoinEvent event) {
    Color originalColor = (event as ChangeColorOfCoinField).originalColor;
    Color convertedColor = event.convertedColor;
    emit(ChangeColorSuccess(data: [originalColor, convertedColor]));
  }

  void _onGetSupportedCurrenciesData() async {
    emit(ConvertCoinLoading());
    List<String> currencies =
        await convertCoinRepository.getSupportedCurrencies();
    if (currencies.isNotEmpty) {
      emit(ShowCoinSuccess(data: currencies));
    } else {
      emit(ConvertCoinLoadFailed(error: AppStrings.errorLoadDataFailed));
    }
  }

  void _onGetPriceConvertedData(ConvertCoinEvent event) async {
    String id = (event as ConvertCoinLoaded).id;
    String currency = event.currency;
    emit(ConvertCoinLoading());
    double price = await convertCoinRepository.getPriceConverted(id, currency);
    if (price != null) {
      emit(ConvertCoinSuccess(data: price));
    } else {
      emit(ConvertCoinLoadFailed(error: AppStrings.errorConvertCoin));
    }
  }
}
