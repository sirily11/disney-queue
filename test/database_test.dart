import 'package:test/test.dart';
import '../bin/Disney/database/database_provider.dart';
import '../bin/Disney/data/Info.dart';

void main() {
  group('Test Database', () {
    test('Write data', () async {
      var databaseProvider = DatabaseProvider();
      var result = await databaseProvider.writeSingle(
        WaitingInfo(
          id: '1',
          dateTime: DateTime.now(),
        ),
      );
      expect(result, true);
    });
  });
}
