import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'data/Info.dart';
import 'disney_base.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;

class ShangHaiDisneyLand extends BaseDisney {
  ShangHaiDisneyLand({Dio networkProvider})
      : super(
          networkProvider: networkProvider ?? Dio(),
          baseURL:
              'https://apim.shanghaidisneyresort.com/explorer-service/public',
          authURL:
              'https://authorization.shanghaidisneyresort.com/curoauth/v1/token',
          authData:
              'grant_type=assertion&assertion_type=public&client_id=DPRD-SHDR.MOBILE.ANDROID-PROD',
          resortId: 'cn',
          resortRegion: 'shdr',
          parkId: 'desShanghaiDisneyland',
          longitude: 121.6580,
          latitude: 31.1433,
        );

  @override
  Future<String> getAuthorizationToken() async {
    try {
      var contentType = 'application/x-www-form-urlencoded';
      var resp = await networkProvider.post(
        authURL,
        data: authData,
        options: Options(contentType: contentType, headers: {
          'User-Agent': userAgent,
        }),
      );
      return resp.data['access_token'];
    } catch (err) {
      print('Cannot get auth token');
      return '';
    }
  }

  @override
  Future<List<WaitingInfo>> fetchWaitingTime() async {
    try {
      var token = await getAuthorizationToken();
      var path = '$baseURL/wait-times/shdr;entityType=destination';
      var data = {'region': resortId};
      // If token is null, then return null
      if (token == null) {
        return null;
      }
      var headers = {
        'Authorization': 'Bearer $token',
      };

      var resp = await networkProvider.get(
        path,
        queryParameters: data,
        options: Options(headers: headers),
      );

      var shanghai =  tz.getLocation('Asia/Shanghai');
      var entries = (resp.data['entries'] as List)
          .map(
            (e) => WaitingInfo.fromJson(e, shanghai),
          )
          .toList();
      return entries;
    } catch (err) {
      print('Cannot fetch waiting time');
      return [];
    }
  }

  @override
  Future<Map<String, dynamic>> fetchFacilitiesData() async {
    var disneyDataFile = File('bin/Disney/data/shanghaiData.json');
    var disneyStringData = await disneyDataFile.readAsString();
    var disneyData = JsonDecoder().convert(disneyStringData);
    return disneyData;
  }
}
