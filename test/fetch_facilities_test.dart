import 'package:test/test.dart';
import 'package:disney_queue/disney_queue.dart';

void main() {
  group('Test get facilities data', () {
    test('Load Data', () {
      var shdl = ShangHaiDisneyLand();
      shdl.getFacilitiesData();
    });
  });
}
