import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String DB_NAME = "vncrypto_db";
const String FOLLOWING_TABLE = "following";

class DatabaseProvider {
  static final DatabaseProvider databaseProvider = DatabaseProvider.init();
  late Database _database;

  DatabaseProvider.init();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initDatabase();
    }
    return _database;
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      version: 1,
      onCreate: (db, version) {
        return db.execute("""CREATE TABLE $FOLLOWING_TABLE (
            id INTEGER PRIMARY KEY
        )""");
      },
    );
  }

  Future close() {
    return _database.close();
  }

  Future deleteDB() async {
    return deleteDatabase(join(await getDatabasesPath(), DB_NAME));
  }
}
