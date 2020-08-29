import 'data/Info.dart';

abstract class BaseDisney {
  final String baseURL;
  final String authURL;
  final String authData;
  final String resortId;
  final String resortRegion;
  final String parkId;
  final String userAgent =
      'Mozilla/5.0 (Linux; U; Android 1.5; en-us; SPH-M900 Build/CUPCAKE) AppleWebKit/528.5  (KHTML, like Gecko) Version/3.1.2 Mobile Safari/525.20.1';

  BaseDisney(
      {required this.baseURL,
      required this.authURL,
      required this.authData,
      required this.resortId,
      required this.resortRegion,
      required this.parkId});

  /// get auth token
  Future<String?> getAuthorizationToken();

  /// Fetching waiting time for the disneyland
  Future<List<WaitingInfo>?> fetchWaitingTime();

  /// write to the database
  Future<void> writeToDB() async {}

  Future fetchFacilitiesData() async {
    var url =
        '${baseURL}explorer-service/public/destinations/${resortId};entityType\u003ddestination/facilities?region=${resortRegion}';
  }
}
