import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_crypto/bloc/list_coin/list_coin_bloc.dart';
import 'package:vn_crypto/bloc/list_coin/list_coin_event.dart';
import 'package:vn_crypto/bloc/list_coin/list_coin_state.dart';
import 'package:vn_crypto/data/model/item_coin.dart';
import 'package:vn_crypto/data/repository/coins_repository.dart';
import 'package:vn_crypto/di/dependency_injection.dart';
import 'package:vn_crypto/ui/components/common/CoinSearchBar.dart';
import 'package:vn_crypto/ui/components/items/ListCoinItem.dart';
import 'package:vn_crypto/ultils/Constraint.dart';

class ListCoinScreen extends StatelessWidget {
  const ListCoinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listCoinBloc =
        ListCoinBloc(listCoinRepository: getIt.get<ListCoinRepository>())
          ..add(ListCoinLoaded());
    return BlocProvider(
        create: (_) => listCoinBloc,
        child: RefreshIndicator(
          onRefresh: () async {
            listCoinBloc.add(ListCoinLoaded());
          },
          child: BlocBuilder<ListCoinBloc, ListCoinState>(
            builder: (context, state) {
              return Scaffold(
                  appBar: AppBar(
                      title: const Text(AppStrings.titleListTopCoin,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(color: Colors.black)),
                      actions: [
                        IconButton(
                          onPressed: () {
                            showSearch(
                                context: context,
                                delegate: CoinSearch(
                                    listCoin: state is ListCoinLoadSuccess
                                        ? state.coins
                                        : []));
                          },
                          icon: const Icon(Icons.search),
                          color: Colors.black,
                        )
                      ]),
                  body: buildBody(state: state));
            },
          ),
        ));
  }

  Widget buildBody({var state}) {
    if (state is ListCoinLoadSuccess) {
      return listCoin(list: state.coins);
    } else if (state is ListCoinLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return const Center(child: Text(AppStrings.textEmptyList));
    }
  }

  Widget listCoin({required List<ItemCoin> list}) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return ListCoinItem(coin: list[index]);
      },
      itemCount: list.length,
      separatorBuilder: (_, context) => const Divider(
        height: 1,
      ),
    );
  }
}
