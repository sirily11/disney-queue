import 'package:meta/meta.dart';

import '../utils/utils.dart';
import 'FacilitiesData.dart';
import 'weatherData.dart';

class WaitingInfo {
  WaitingInfo({
    @required this.id,
    this.waitTime,
    this.facilitiesData,
    @required this.dateTime,
    this.weatherData,
  });

  final String id;
  final WaitTime waitTime;
  final FacilitiesData facilitiesData;
  final DateTime dateTime;
  final WeatherData weatherData;

  @override
  String toString(){
    return '[waitingInfo: ${facilitiesData.name} - ${waitTime.status}]';
  }

  WaitingInfo copyWith({
    String id,
    WaitTime waitTime,
    FacilitiesData facilitiesData,
    DateTime dateTime,
    WeatherData weatherData,
  }) =>
      WaitingInfo(
        id: id ?? this.id,
        facilitiesData: facilitiesData ?? this.facilitiesData,
        waitTime: waitTime ?? this.waitTime,
        dateTime: dateTime ?? this.dateTime,
        weatherData: weatherData ?? this.weatherData,
      );

  factory WaitingInfo.fromJson(Map<String, dynamic> json) => WaitingInfo(
        id: json['id'],
        waitTime: WaitTime.fromJson(json['waitTime']),
        dateTime: json['dateTime'] != null ? DateTime.parse(json['dateTime']) : DateTime.now(),
        facilitiesData: json['facilitiesData'],
        weatherData: json['weatherData'] != null
            ? WeatherData.fromJson(json['weatherData'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'waitTime': waitTime?.toJson(),
        'dateTime': dateTime.toIso8601String(),
        'facilitiesData': facilitiesData,
        'weatherData': weatherData?.toJson(),
      };

  String get cleanId {
    return getCleanID(id);
  }
}

class WaitTime {
  WaitTime({
    this.fastPass,
    this.status,
    this.singleRider,
  });

  FastPass fastPass;
  String status;
  bool singleRider;

  factory WaitTime.fromJson(Map<String, dynamic> json) => WaitTime(
        fastPass: FastPass.fromJson(json['fastPass']),
        status: json['status'],
        singleRider: json['singleRider'],
      );

  Map<String, dynamic> toJson() => {
        'fastPass': fastPass?.toJson(),
        'status': status,
        'singleRider': singleRider,
      };
}

class FastPass {
  FastPass({
    this.available,
  });

  bool available;

  factory FastPass.fromJson(Map<String, dynamic> json) => FastPass(
        available: json['available'],
      );

  Map<String, dynamic> toJson() => {
        'available': available,
      };
}
