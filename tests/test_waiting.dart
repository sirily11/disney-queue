import 'package:test/test.dart';
import '../bin/Disney/data/Info.dart';

void main() {
  group('Test waiting', () {
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
  });
}
