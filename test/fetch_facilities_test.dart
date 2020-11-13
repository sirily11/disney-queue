import 'package:test/test.dart';
import 'package:disney_queue/disney_queue.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;

void main() {
  group('Test get facilities data', () {
    setUp(() async {
      tz.initializeTimeZones();
    });
    test('Load Data', () {
      var shdl = ShangHaiDisneyLand();
      shdl.getFacilitiesData();
    });
  });
}
