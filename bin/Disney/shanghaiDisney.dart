import 'package:dio/dio.dart';

import 'data/Info.dart';
import 'disney_base.dart';

class ShangHaiDisneyLand extends BaseDisney {
  ShangHaiDisneyLand()
      : super(
          baseURL:
              'https://apim.shanghaidisneyresort.com/explorer-service/public',
          authURL:
              'https://authorization.shanghaidisneyresort.com/curoauth/v1/token',
          authData:
              'grant_type=assertion&assertion_type=public&client_id=DPRD-SHDR.MOBILE.ANDROID-PROD',
          resortId: 'cn',
          resortRegion: 'shdr',
          parkId: 'desShanghaiDisneyland',
        );

  @override
  Future<String?> getAuthorizationToken() async {
    try {
      var contentType = 'application/x-www-form-urlencoded';
      var resp = await Dio().request(
        authURL,
        data: authData,
        options: Options(contentType: contentType, method: 'POST', headers: {
          'User-Agent': userAgent,
        }),
      );
      return resp.data['access_token'];
    } catch (err) {
      print('Cannot get auth token');
    }
  }

  @override
  Future<List<WaitingInfo>?> fetchWaitingTime() async {
    try {
      var token = await getAuthorizationToken();
      var path = '$baseURL/wait-times/shdr;entityType=destination';
      var data = {'region': resortRegion};
      // If token is null, then return null
      if (token == null) {
        return null;
      }
      var headers = {
        'Authorization': 'Bearer $token',
        'X-Conversation-Id': 'WDW-MDX-ANDROID-4.12',
        'X-Correlation-ID': DateTime.now().millisecondsSinceEpoch,
      };

      var resp = await Dio().request(
        path,
        queryParameters: data,
        options: Options(headers: headers, method: 'get'),
      );

      var entries = (resp.data['entries'] as List)
          .map((e) => WaitingInfo.fromJson(e))
          .toList();
      return entries;
    } catch (err) {
      print('Cannot fetch waiting time');
    }
  }
}
