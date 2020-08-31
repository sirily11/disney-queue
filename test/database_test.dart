import 'package:test/test.dart';
import 'package:disney_queue/disney_queue.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;

void main() {
  group('Test Database', () {
    setUpAll(()async{
      tz.initializeTimeZones();
    });
    test('Write data', () async {
      var shanghai = await tz.getLocation('Asia/Shanghai');
      var now = tz.TZDateTime.now(shanghai);
      var databaseProvider = DatabaseProvider();
      var result = await databaseProvider.writeSingle(
        WaitingInfo(
          id: '1',
          dateTime: now,
        ),
      );
      expect(result, true);
    });
  });
}
