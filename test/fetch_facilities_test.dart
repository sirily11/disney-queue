import 'package:test/test.dart';
import '../bin/Disney/shanghaiDisney.dart';

void main() {
  group('Test get facilities data', () {
    test('Load Data', () {
      var shdl = ShangHaiDisneyLand();
      shdl.getFacilitiesData();
    });
  });
}
