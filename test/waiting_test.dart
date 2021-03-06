import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:disney_queue/disney_queue.dart';
import 'test_response.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;

class MockDio extends Mock implements Dio {}

void main() {
  group('Test waiting', () {
    Dio dio = MockDio();

    setUpAll(() async {
      await tz.initializeTimeZones();
      when(
        dio.get(
          'https://apim.shanghaidisneyresort.com/explorer-service/public/wait-times/shdr;entityType=destination',
          options: anyNamed('options'),
          queryParameters: anyNamed('queryParameters'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(data: waitTimeResponse),
      );

      when(
        dio.post(
          any,
          options: anyNamed('options'),
          data: anyNamed('data'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          data: {'access_token': 'abc'},
        ),
      );

      when(
        dio.get(
          'https://api.openweathermap.org/data/2.5/weather',
          options: anyNamed('options'),
          queryParameters: anyNamed('queryParameters'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          data: weatherResponse,
        ),
      );
    });

    test('Test 1', () {
      var info = WaitingInfo(
          id: 'attCampDiscovery;entityType=Attraction;destination=shdr');
      var result = info.cleanId;
      expect(result, 'attCampDiscovery');
    });

    test('Test 2', () {
      var info = WaitingInfo(
          id: 'attChallengeTrails;entityType=Attraction;destination=shdr');
      var result = info.cleanId;
      expect(result, 'attChallengeTrails');
    });

    test('Test 3', () async {
      var disney = ShangHaiDisneyLand(networkProvider: dio);
      var waitingTime = await disney.getWaitingTime();
      expect(waitingTime.length, 43);
      waitingTime.forEach((element) {
        expect(element.waitTime != null, true);
        expect(element.id != null, true);
        expect(element.weatherData != null, true);
      });
    });

    test('Test to json', () async {
      var shanghai = await tz.getLocation('Asia/Shanghai');
      var now = tz.TZDateTime.now(shanghai);
      var waitingTime = WaitingInfo(
        id: '1',
        dateTime: now,
        weatherData: WeatherData.fromJson(weatherResponse),
      );

      var json = waitingTime.toJson();
      expect(json != null, true);
    });
  });
}
