import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vn_crypto/bloc/invest_management/invest_management_bloc.dart';
import 'package:vn_crypto/bloc/invest_management/invest_management_event.dart';
import 'package:vn_crypto/bloc/invest_management/invest_management_state.dart';
import 'package:vn_crypto/data/model/item_coin.dart';
import 'package:vn_crypto/data/repository/InvestRepository.dart';
import 'package:vn_crypto/di/dependency_injection.dart';
import 'package:vn_crypto/ui/components/items/InvestItem.dart';
import 'package:vn_crypto/ui/investmanagement/select_invest_dialog.dart';
import 'package:vn_crypto/ultils/Constant.dart';

class InvestManagementScreen extends StatefulWidget {
  const InvestManagementScreen({Key? key}) : super(key: key);

  @override
  _InvestManagementScreenState createState() => _InvestManagementScreenState();
}

class _InvestManagementScreenState extends State<InvestManagementScreen> {
  final double currentBalance = 0.0;
  final double balanceChange = 0.0;
  final double totalProfitLoss = 0.0;
  final double totalProfitLossPercent = 0.00;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => InvestManagementBloc(investRepository: getIt.get<InvestRepository>())
          ..add(InvestManagementLoaded()),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              AppStrings.investManagement,
              style: TextStyle(color: Colors.black),
              textDirection: TextDirection.ltr,
            ),
            elevation: 0,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 10),
                child: Text(
                  AppStrings.currentBalance,
                  style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.75)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 4),
                child: Text(
                  "$currentBalance\$",
                  style: const TextStyle(
                      fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 4),
                child: Text(
                  balanceChange >= 0 ? "+$balanceChange\$ (24h)" : "-$balanceChange\$ (24h)",
                  style: const TextStyle(
                    color: Color(AppColors.colorMountainMeadow),
                    fontSize: 14,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 28),
                child: SizedBox(height: 72, width: double.infinity, child: totalProfitView()),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 30),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Switch(value: true, onChanged: (value) {})),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  AppStrings.yourAssets,
                  style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              BlocBuilder<InvestManagementBloc, InvestManagementState>(
                builder: (context, state) {
                  if (state is InvestManagementSuccess) {
                    List<ItemCoin> itemCoins = state.data as List<ItemCoin>;
                    return ListView.builder(
                        itemCount: itemCoins.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return InvestItem(itemCoin: itemCoins[index]);
                        });
                  } else {
                    return Container();
                  }
                },
              ),
              Padding(padding: const EdgeInsets.only(left: 16, right: 16), child: addNewButton()),
            ],
          ),
        ));
  }

  Widget totalProfitView() {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(AppColors.colorWildSand))),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  AppStrings.totalProfitLoss,
                  style: TextStyle(color: Colors.black.withOpacity(0.75), fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Text(
                  totalProfitLoss >= 0 ? "+$totalProfitLoss\$" : "-$totalProfitLoss\$",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              )
            ],
          ),
        ),
        Positioned(
            bottom: 4,
            right: 14,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4, bottom: 2),
                  child: SvgPicture.asset(totalProfitLossPercent >= 0
                      ? ImageAssetString.icPriceUp
                      : ImageAssetString.icPriceDown),
                ),
                Text(
                  "$totalProfitLossPercent\%",
                  style: const TextStyle(color: Color(AppColors.colorMountainMeadow), fontSize: 14),
                ),
              ],
            ))
      ],
    );
  }

  Widget addNewButton() {
    return GestureDetector(
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: const Color(AppColors.colorDodgerBlue),
          child: const Align(
            alignment: Alignment.center,
            child: Text(
              AppStrings.addNewAsset,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: const AddInvestDialog());
            });
      },
    );
  }
}
