import 'dart:io';

import 'package:dio/dio.dart';

import '../data/Info.dart';
import '../data/Info.dart';

class APIProvider {
  Future<void> upload(List<WaitingInfo> waitingInfo, String location) async {
    final dio = Dio();
    final env = Platform.environment;
    final username = env['username'];
    final password = env['password'];
    final apiBackend = env['apiBackend'];

    final authBackend = apiBackend + 'api/token/';
    final dataBackend = apiBackend + 'api/disney/waittime/';

    final authResponse = await dio
        .post(authBackend, data: {'username': username, 'password': password});

    final token = authResponse.data['access'];
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final data = _getData(waitingInfo, location);
    await dio.post(
      dataBackend,
      data: data,
      options: Options(headers: headers),
    );
  }

  Map<String, dynamic> _getData(List<WaitingInfo> info, String location) {
    final weather = info.first.weatherData;
    final weatherData = weather.toAPIJson(location);

    final facilities = info.map((e) {
      final f = e.facilitiesData;
      final data = e.waitTime.toJson();

      data['facility_name'] = f.name;
      data['facility_type'] = f.type;
      data['facility_id'] = f.id;
      data['fast_pass'] = e.waitTime.fastPass.available;
      data['wait_time'] = e.waitTime.postedWaitMinutes;

      return data;
    }).toList();

    return {'weather_data': weatherData, 'facilities': facilities};
  }
}
