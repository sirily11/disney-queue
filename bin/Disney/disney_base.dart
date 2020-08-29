import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import 'data/FacilitiesData.dart';
import 'data/Info.dart';

abstract class BaseDisney {
  final Dio networkProvider;
  final String baseURL;
  final String authURL;
  final String authData;
  final String resortId;
  final String resortRegion;
  final String parkId;
  final String userAgent =
      'Mozilla/5.0 (Linux; U; Android 1.5; en-us; SPH-M900 Build/CUPCAKE) AppleWebKit/528.5  (KHTML, like Gecko) Version/3.1.2 Mobile Safari/525.20.1';

  BaseDisney({
    this.networkProvider,
    this.baseURL,
    this.authURL,
    this.authData,
    this.resortId,
    this.resortRegion,
    this.parkId,
  });

  /// get auth token
  Future<String> getAuthorizationToken();

  /// get waiting time
  Future<List<WaitingInfo>> getWaitingTime() async {
    var facilitiesData = await getFacilitiesData();
    var waitingTime = await getWaitingTime();

    // ignore: omit_local_variable_types
    List<WaitingInfo> waitingInfo = [];
    waitingTime.forEach((element) {
      if (facilitiesData.containsKey(element.cleanId)) {
        waitingInfo.add(
          element.copyWith(
            facilitiesData: facilitiesData[element.cleanId],
          ),
        );
      }
    });
  }

  /// Fetching waiting time for the disneyland. Use getWaitingTime instead
  Future<List<WaitingInfo>> fetchWaitingTime();

  /// write to the database
  Future<void> writeToDB() async {}

  /// Fetch facilitiesData from json file
  /// Use getFacilitiesData to get list of facilitiesData
  Future<Map<String, dynamic>> fetchFacilitiesData();

  /// Get a list of facilities data
  Future<Map<String, FacilitiesData>> getFacilitiesData() async {
    var disneyData = await fetchFacilitiesData();

    var updatedData = (disneyData['updated'] as List)
        .map((e) => FacilitiesData.fromJson(e))
        .toList();

    var addedData = (disneyData['added'] as List)
        .map((e) => FacilitiesData.fromJson(e))
        .toList();

    // ignore: omit_local_variable_types
    Map<String, FacilitiesData> map = {};

    [...updatedData, ...addedData]
        .where((element) =>
            element.type == 'Attraction' || element.type == 'Entertainment')
        .forEach((element) {
      map.putIfAbsent(element.cleanId, () => element);
    });

    return map;
  }
}
