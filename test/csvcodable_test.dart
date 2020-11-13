import 'package:test/test.dart';
import 'package:disney_queue/disney_queue.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;

class A with CsvCodable {
  int a = 10;
  String b = '20';
  C c = C();
  int d;

  @override
  List<RowResult> get variables => [
        RowResult(variableName: 'a', value: a),
        RowResult(variableName: 'b', value: b),
        RowResult(
          value: c,
        ),
        RowResult(variableName: 'd', value: d),
      ];
}

class C with CsvCodable {
  int e = 40;

  @override
  List<RowResult> get variables => [RowResult(variableName: 'e', value: e)];
}

void main() {
  group('Test csv codable', () {
    setUpAll(() async {
      tz.initializeTimeZones();
    });

    test('Test to csv row', () {
      var a = A();
      var result = a.toCsvRow();
      expect(result.length, 4);
      expect(result.map((e) => e.value).toList(), [10, '20', 40, null]);
    });

    test('Convert waiting time', () async {
      var shanghai = await tz.getLocation('Asia/Shanghai');
      var now = tz.TZDateTime.now(shanghai);
      var waitingInfo = WaitingInfo(
        id: '1',
        dateTime: now,
        waitTime: WaitTime(
          fastPass: FastPass(available: true),
          status: 'Operating',
          postedWaitMinutes: 30,
        ),
        facilitiesData: FacilitiesData(name: 'Ride', type: 'Entertainment;'),
        weatherData: WeatherData(
            visibility: 30,
            main: Main(
                temp: 300,
                tempMax: 300,
                tempMin: 300,
                humidity: 40,
                pressure: 700,
                feelsLike: 300),
            clouds: Clouds(all: 60),
            wind: Wind(deg: 20, speed: 20)),
      );

      var result = waitingInfo.toCsvRow();
      expect(result.length, 16);
    });
  });
}
