import 'package:sembast/sembast_io.dart';
import '../data/Info.dart';
import 'provider.dart';
import 'package:sembast/sembast.dart';

class DatabaseProvider extends DataProvider<DatabaseFactory, WaitingInfo> {
  Database db;

  DatabaseProvider({
    DatabaseFactory databaseFactory,
  }) : super(
          dataClient: databaseFactory ?? databaseFactoryIo,
          name: 'data/disney.db',
        );

  @override
  Future<bool> writeSingle(WaitingInfo data) async {
    try {
      if (db == null) {
        await onInit();
      }
      var store = StoreRef.main();
      await store.record('disney').put(db, data.toJson());
    } catch (err) {
      print('cannot insert to the database');
      return false;
    }
    return true;
  }

  @override
  Future<void> onInit() async {
    db = await dataClient.openDatabase(name);
  }
}
