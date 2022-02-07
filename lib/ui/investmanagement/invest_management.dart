import 'package:flutter/material.dart';
import 'package:vn_crypto/ultils/Constant.dart';

class InvestManagementScreen extends StatefulWidget {
  const InvestManagementScreen({Key? key}) : super(key: key);

  @override
  _InvestManagementScreenState createState() => _InvestManagementScreenState();
}

class _InvestManagementScreenState extends State<InvestManagementScreen> {
  final double currentBalance = 0.0;
  final double balanceChange = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              style:
                  const TextStyle(fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold),
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
              child: totalProfitView())
        ],
      ),
    );
  }

  Widget totalProfitView() {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 72,
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
              )
            ],
          ),
        )
      ],
    );
  }
}
