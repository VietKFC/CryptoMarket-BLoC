import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vn_crypto/data/model/item_coin.dart';
import 'package:vn_crypto/ui/components/common/price_change.dart';
import 'package:vn_crypto/ultils/Constraint.dart';

class ListCoinItem extends StatelessWidget {
  final ItemCoin coin;

  const ListCoinItem({required this.coin, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(coin.image, width: 35, height: 35),
              const SizedBox(width: 6),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleWithFollow(title: coin.name),
                  const SizedBox(height: 4),
                  rankAndPriceVolatility(rank: '${coin.rank}')
                ],
              ),
              Expanded(
                  child: priceAndMarketCap(
                      price: '${coin.curerentPrice}',
                      mCap: '${coin.marketCap}'))
            ],
          ),
        ),
      ],
    );
  }

  Widget titleWithFollow({required String title}) {
    return Row(
      children: [
        Text(title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(width: 8),
        SvgPicture.asset(
          ImageAssetString.icUnFollowing,
          width: 16,
        )
      ],
    );
  }

  Widget rankAndPriceVolatility({required String rank}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              color: const Color(AppColors.colorMercury),
              borderRadius: BorderRadius.circular(3)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(6, 2, 6, 1),
            child: Text(
              rank,
              style: const TextStyle(fontSize: 10),
            ),
          ),
        ),
        const SizedBox(width: 8),
        PriceChange(priceChangeRate: coin.changePercent)
      ],
    );
  }

  Widget priceAndMarketCap({required String price, required String mCap}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: AlignmentDirectional.topEnd,
          child: Text(
            '\$$price',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Align(
          alignment: AlignmentDirectional.bottomEnd,
          child: Baseline(
            baseline: 16,
            baselineType: TextBaseline.alphabetic,
            child: Text(
              '${AppStrings.textMarketCap}$mCap',
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        )
      ],
    );
  }
}
