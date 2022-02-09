import 'package:flutter/material.dart';
import 'package:vn_crypto/data/model/item_coin.dart';

class InvestItem extends StatefulWidget {
  final ItemCoin itemCoin;

  const InvestItem({Key? key, required this.itemCoin}) : super(key: key);

  @override
  _InvestItemState createState() => _InvestItemState();
}

class _InvestItemState extends State<InvestItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Image.network(
            widget.itemCoin.image,
            width: 35,
            height: 35,
          ),
        ),
        Column(
          children: [
            //TODO implement later
          ],
        )
      ],
    );
  }
}
