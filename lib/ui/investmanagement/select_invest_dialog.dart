import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_crypto/bloc/invest_management/invest_management_bloc.dart';
import 'package:vn_crypto/bloc/invest_management/invest_management_event.dart';
import 'package:vn_crypto/bloc/invest_management/invest_management_state.dart';
import 'package:vn_crypto/data/model/item_coin.dart';
import 'package:vn_crypto/data/repository/InvestRepository.dart';
import 'package:vn_crypto/di/dependency_injection.dart';
import 'package:vn_crypto/ui/components/common/CoinSearchBarSymbol.dart';
import 'package:vn_crypto/ultils/Constant.dart';

class AddInvestDialog extends StatefulWidget {
  const AddInvestDialog({Key? key}) : super(key: key);

  @override
  _AddInvestDialogState createState() => _AddInvestDialogState();
}

class _AddInvestDialogState extends State<AddInvestDialog> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: dialogLayout(),
    );
  }

  Widget dialogLayout() {
    return BlocProvider(
      create: (_) => InvestManagementBloc(investRepository: getIt.get<InvestRepository>())
        ..add(InvestManagementCoinMarketLoaded("usd")),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 23, right: 23),
                  child: Image.asset(
                    ImageAssetString.icSearch,
                    width: 23,
                    height: 23,
                  ),
                ),
                const SearchBarSymbol(),
              ],
            ),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 20),
                child: BlocBuilder<InvestManagementBloc, InvestManagementState>(
                  builder: (context, state) {
                    if (state is InvestManagementSuccess) {
                      List<ItemCoin> itemCoins = state.data as List<ItemCoin>;
                      return ListView.builder(
                          itemCount: itemCoins.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black.withOpacity(0.2))),
                              ),
                              child: GestureDetector(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 16),
                                          child: Image.network(
                                            itemCoins[index].image,
                                            width: 22,
                                            height: 22,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10, top: 20, bottom: 20),
                                          child: Text(
                                            itemCoins[index].symbol.toUpperCase(),
                                            style:
                                                const TextStyle(fontSize: 16, color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: Image.asset(
                                        ImageAssetString.icExpand,
                                        width: 13,
                                        height: 15,
                                      ),
                                    )
                                  ],
                                ),
                                onTap: () {},
                              ),
                            );
                          });
                    } else if (state is InvestManagementLoading) {
                      return const Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Container();
                    }
                  },
                )),
          )
        ],
      ),
    );
  }
}
