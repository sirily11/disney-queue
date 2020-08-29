import 'package:test/test.dart';
import '../Disney/shanghaiDisney.dart';

void main() {
  group('Test get facilities data', () {
    test('Load Data', () {
      var shdl = ShangHaiDisneyLand();
      shdl.getFacilitiesData();
    });
  });
}
