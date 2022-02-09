import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_crypto/bloc/invest_management/invest_management_event.dart';
import 'package:vn_crypto/bloc/invest_management/invest_management_state.dart';
import 'package:vn_crypto/data/model/item_coin.dart';
import 'package:vn_crypto/data/repository/InvestRepository.dart';
import 'package:vn_crypto/ultils/Constant.dart';

class InvestManagementBloc extends Bloc<InvestManagementEvent, InvestManagementState> {
  final InvestRepository investRepository;

  InvestManagementBloc({required this.investRepository}) : super(InvestManagementInitialize()) {
    on<InvestManagementLoaded>((_, emit) => _onGetAllInvests());
    on<InvestManagementSaveCoin>((event, _) => _onSaveInvest(event));
    on<InvestManagementDeleteCoin>((event, _) => _onDeleteInvest(event));
    on<InvestManagementCoinMarketLoaded>((event, _) => _onGetAllCoinMarket(event));
  }

  void _onGetAllInvests() async {
    emit(InvestManagementLoading());
    List<ItemCoin> itemCoins = await investRepository.getAllInvests();
    if (itemCoins.isEmpty) {
      emit(InvestManagementFailed(AppStrings.errorLoadDataFailed));
    } else {
      emit(InvestManagementSuccess(itemCoins));
    }
  }

  void _onSaveInvest(InvestManagementEvent event) async {
    ItemCoin itemCoin = (event as InvestManagementSaveCoin).itemCoin;
    emit(InvestManagementLoading());
    await investRepository.saveInvest(itemCoin);
    emit(InvestManagementSuccess(AppStrings.messageSaveInvestSuccess));
  }

  void _onDeleteInvest(InvestManagementEvent event) async {
    ItemCoin itemCoin = (event as InvestManagementDeleteCoin).itemCoin;
    emit(InvestManagementLoading());
    await investRepository.deleteInvest(itemCoin);
    emit(InvestManagementSuccess(AppStrings.messageDeleteInvestSuccess));
  }

  void _onGetAllCoinMarket(InvestManagementEvent event) async {
    String currency = (event as InvestManagementCoinMarketLoaded).currency;
    emit(InvestManagementLoading());
    List<ItemCoin> itemCoins = await investRepository.getAllCoinMarket(currency);
    if (itemCoins.isEmpty) {
      emit(InvestManagementFailed(AppStrings.errorLoadDataFailed));
    } else {
      emit(InvestManagementSuccess(itemCoins));
    }
  }
}
