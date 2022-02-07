import 'package:vn_crypto/data/database/database.dart';
import 'package:vn_crypto/data/model/item_coin.dart';
import 'package:vn_crypto/di/dependency_injection.dart';

class InvestRepository {
  DatabaseProvider databaseProvider = getIt.get<DatabaseProvider>();

  Future<List<ItemCoin>> getAllInvests() => databaseProvider.getAllInvests();

  Future<int> saveInvest(ItemCoin itemCoin) => databaseProvider.insertInvest(itemCoin);

  Future<int> deleteInvest(ItemCoin itemCoin) => databaseProvider.deleteInvest(itemCoin);
}
