import 'package:test/test.dart';
import '../bin/Disney/data/Info.dart';

class A with CsvCodable {
  int a = 10;
  String b = '20';
  C c = C();
  int d;

  A() {
    variables = [a, b, c, d];
  }
}

class C with CsvCodable {
  int e = 40;

  C() {
    variables = [e];
  }
}

void main() {
  group('Test csv codable', () {
    test('Test to csv row', () {
      var a = A();
      var result = a.toCsvRow();
      expect(result.length, 4);
    });
  });
}
